import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/payment_screen.dart';
import 'package:food_line/screens/qr_code_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/livreur_widget.dart';
import 'package:food_line/widgets/markerwidget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/payment_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);

class StationsScreen extends ConsumerStatefulWidget {
  final String? type;
  final String? idAd;
  final String? prix;
  final String? dayLiv;
  final List<double>? position;

  const StationsScreen(
      {Key? key, this.type, this.dayLiv, this.idAd, this.prix, this.position})
      : super(key: key);

  @override
  _StationsScreenState createState() => _StationsScreenState();
}

class _StationsScreenState extends ConsumerState<StationsScreen> {
  String img = '';
  int? itemLength, index;

  Set<Marker> marks = {};
  bool selected = false;
  CameraPosition? cameraPosition;
  List<bool> myList = [];
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 50.0);
  bool isloading = true;
  String? anonyme;
  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(widget.position?[0] ?? 0, widget.position?[1] ?? 0),
      zoom: 12,
    );

    getStations();
  }

  getStations() async {
    final viewModel = ref.read(panierProvider);
    print(widget.idAd! + widget.type!);
    bool? isToday;
    if (widget.dayLiv == "Now") {
      isToday = true;
    } else {
      isToday = false;
    }
    await viewModel
        .getListStation(context, widget.idAd, widget.type, null, isToday)
        .then(
      (value) {
        setState(() {
          itemLength = viewModel.listStations?.listeStations?.length ?? 0;
        });
      },
    );
    for (int i = 0; i < itemLength!; i += 1) {
      myList.add(false);
      double lat, lng;
      lat = viewModel.listStations?.listeStations?[i].postion?[0] ?? 0;
      lng = viewModel.listStations?.listeStations?[i].postion?[1] ?? 0;
      print('NETWORK IMAGE $i');
      print(viewModel.listStations?.listeStations?[i].livreur?.image);

      //TODO put image
      String? urlImage =
          viewModel.listStations?.listeStations?[i].livreur?.image;
      print('THE TEST IS HEREEE URL: $urlImage');
      final cintroller = ScreenshotController();

      final myBytes = await cintroller.captureFromWidget(
        MarkerWidget(
          imagePath: urlImage ?? '',
        ),
      );
      setState(() {});

      img = urlImage ?? '';
      Uint8List? dataBytes;
      var request = await http.get(Uri.parse(urlImage ?? ''));
      Uint8List bytes = request.bodyBytes;
      setState(() {
        dataBytes = myBytes;
      });
      setState(() {
        marks.add(
          Marker(
            icon: BitmapDescriptor.fromBytes(dataBytes!.buffer.asUint8List()),
            onTap: () => setState(() {
              index = i;
              selected = true;
            }),
            markerId: MarkerId('home$i'),
            position: LatLng(lat, lng),
          ),
        );
      });
    }
    setState(() {
      isloading = false;
    });
  }

  createMarker() {
    ImageConfiguration configuration = createLocalImageConfiguration(context);
  }

  String? idlivreur;
  String? idStation;
  String? trajetCamion;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(panierProvider);
    print('IMAGGGEEEE');
    print(img);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: viewModel.listStations == null || isloading
              ? Container(
                  height: getHeight(context),
                  width: getWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20.h),
                      Container(
                        padding: EdgeInsets.all(10.w),
                        child: Text(
                            'Veuillez patienter, votre liste de livreurs est en cours de chargement',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 36.h,
                            horizontal: 36.w,
                          ),
                          child: Row(
                            children: [
                              // MyWidgetButton(
                              //   widget: myBackIcon,
                              //   onTap: () => Navigator.pop(context),
                              // ),
                              // SizedBox(
                              //   width: 50.w,
                              // ),
                              Text(
                                'Les stations',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: my_green),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100.h, left: 36.w),
                      child: Text(
                        "Sélectionner la station :",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    GoogleMap(
                      initialCameraPosition: cameraPosition!,
                      markers: marks,
                    ),
                    index != null
                        ? Positioned(
                            bottom: 80.h,
                            left: 36.w,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: my_black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                              ),
                              height: 142.h,
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 21.h),
                                      child: LivreurWidget(
                                        isTaped: myList[index!],
                                        taped: () {},
                                        livreurAdresse: viewModel
                                                .listStations
                                                ?.listeStations?[index!]
                                                .nomStation ??
                                            "",
                                        livreurName: (viewModel
                                                    .listStations
                                                    ?.listeStations?[index!]
                                                    .livreur
                                                    ?.name ??
                                                "") +
                                            " " +
                                            (viewModel
                                                    .listStations
                                                    ?.listeStations?[index!]
                                                    .livreur
                                                    ?.prenom ??
                                                ""),
                                        livreurRate: 5,
                                        livreurPhotoPath: viewModel
                                                .listStations
                                                ?.listeStations?[index!]
                                                .livreur
                                                ?.image ??
                                            "",
                                        locationName: 'Arrivée :' +
                                            (viewModel
                                                    .listStations
                                                    ?.listeStations?[index!]
                                                    .heureArrive ??
                                                "") +
                                            "   " +
                                            'Départ :' +
                                            (viewModel
                                                    .listStations
                                                    ?.listeStations?[index!]
                                                    .heureDepart ??
                                                ""),
                                        time:
                                            "${viewModel.listStations?.listeStations?[index!].temps}" +
                                                'min',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MyWidgetButton(
                          widget: CommanderWidget(
                            title: "Confirmer",
                            titleLeftPadding: 41,
                            priceLeftPadding: 24,
                            myPrice: '${widget.prix}€',
                          ),
                          onTap: () {
                            selected
                                ? viewModel.affecterAdressLivraisonCommande(
                                    context,
                                    viewModel
                                        .listStations
                                        ?.listeStations?[index!]
                                        .livreur
                                        ?.identifiant,
                                    viewModel.listStations
                                        ?.listeStations?[index!].idStation,
                                    viewModel.listStations
                                        ?.listeStations?[index!].trajetCamion,
                                    widget.idAd,
                                    widget.prix,
                                    viewModel.listStations
                                        ?.listeStations?[index!].nomStation,
                                    viewModel.listStations
                                        ?.listeStations?[index!].livreur?.name,
                                    viewModel.listStations
                                        ?.listeStations?[index!].heureDepart,
                                    viewModel.listStations
                                        ?.listeStations?[index!].heureArrive)
                                : showToast(
                                    'veuillez choisir un livreur s\'il vous plait',
                                  );
                          },
                          color: Colors.black.withOpacity(selected ? 1 : 0.4),
                          width: 303,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
  }
}
