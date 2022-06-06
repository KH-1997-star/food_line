import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/livraison_quand_repo.dart';
import 'package:food_line/screens/notification.dart';
import 'package:food_line/services/location_service.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/indic_container_widget.dart';
import 'package:food_line/widgets/localisation_enregistrer_widget.dart';
import 'package:food_line/widgets/locasearch_widget.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';
import 'package:food_line/widgets/titre_food_line_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

final LivProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);
final tempsLivProvider = ChangeNotifierProvider<TempsLivNotifier>(
  (ref) => TempsLivNotifier(),
);

class LocationLivreurScreen extends ConsumerStatefulWidget {
  final bool fromMenu;
  final String? id;
  final double? lat;
  final double? lng;
  const LocationLivreurScreen(
      {this.fromMenu = false, this.lat, this.lng, this.id, Key? key})
      : super(key: key);

  @override
  _LocationLivreurScreenState createState() => _LocationLivreurScreenState();
}

class _LocationLivreurScreenState extends ConsumerState<LocationLivreurScreen> {
  int? itemLength;
  double myLat = 49.24252599999999;
  double myLng = 1.595405;

  String myPlace = 'Rouan, France';
  String? ville = "Rouan";
  String? pays = "France";
  String? codePostal = "09700";
  String? adresse = "rue jeanne d'arc";
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition? _kGooglePlex;
  @override
  void initState() {
    //print('YESSSS IAM THE RIGHT PAGE');
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(50, 50)), 'icons/delivery_truck.png')
        .then((onValue) {
      myIcon = onValue;
    });
    Timer(const Duration(milliseconds: 50), () {
      setState(
        () {
          startAnimation = true;
        },
      );
    });
    // getListAdd();
    getListeLivreur();
    super.initState();
  }

  bool startAnimation = false;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Set<Marker> _markers = {};
  BitmapDescriptor? myIcon;
  getListeLivreur() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('icons/delivery_truck.png', 100);
    var viewModel = await ref.read(LivProvider);
    bool? isToday;

    viewModel
        .getListStation(context, widget.id, "Midi", null, true)
        .then((value) {
      print("IDDDDDDDD");
      print(widget.id);
      print(viewModel.listStations!.listeStations!.length);
      for (final dnn in viewModel.listStations!.listeStations!) {
        setState(() {
          _markers.add(Marker(
              markerId: MarkerId(dnn.idStation.toString()),
              position: LatLng(dnn.postion![0], dnn.postion![1]),
              icon: BitmapDescriptor.fromBytes(markerIcon),
              infoWindow: InfoWindow(
                title: dnn.livreur!.name ?? "",
              )));
        });
      }

      setState(() {
        isLoading = false;
        _markers.add(Marker(
            markerId: MarkerId('my Position'),
            position: LatLng(widget.lat!, widget.lng!),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: "Mon adresse",
            )));
      });

      print(_markers);
    });
  }

  bool isLoading = true;
  List<bool> myList = [];
  var place;
  var lat = 48.8566;
  var lng = 2.3522;
  Polyline polyline = const Polyline(
    polylineId: PolylineId('pos1_pos2'),
    points: [
      LatLng(40.683749622885465, -73.93551726787483),
      LatLng(40.67876632842902, -73.93727259437823)
    ],
    color: Colors.amber,
    width: 2,
  );

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(LivProvider);

    return viewModel.listStations == null || isLoading
        ? Container(
            color: Colors.white,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: LoadingIndicator(
                  color: my_green,
                  indicatorType: Indicator.ballRotateChase,
                ),
              ),
            ))
        : viewModel.listStations!.listeStations!.isEmpty
            ? SafeArea(
                child: Scaffold(
                  backgroundColor: const Color(0xffFBFAFF),
                  body: Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: getHeight(context),
                          width: getWidth(context),
                          //color: Colors.white,
                        ),
                        AnimatedPositioned(
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                          top: startAnimation ? 30.h : 55.h,
                          right: 36.w,
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                child: const NotificationScreen(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 500),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'icons/notification.svg',
                              height: 24.h,
                              width: 19.5.w,
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                          top: startAnimation ? 20.h : 0,
                          left: 128.w,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                startAnimation = false;
                              });
                              Timer(const Duration(milliseconds: 200), () {
                                Navigator.pop(context);
                              });
                            },
                            child: const TitreFoodLine(),
                          ),
                        ),
                        // Positioned(
                        //   top: 77.h,
                        //   left: 9.1.w,
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         width: 6.w,
                        //       ),
                        //       SvgPicture.asset(
                        //         'icons/voiture.svg',
                        //         height: 15.h,
                        //         width: 53.17.w,
                        //       ),
                        //       SizedBox(
                        //         width: 8.3.w,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Text(
                        //             'Sélectionnez votre position',
                        //             style: TextStyle(fontSize: 14.sp),
                        //           ),
                        //           const Icon(
                        //             Icons.keyboard_arrow_down_rounded,
                        //             color: my_green,
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // AnimatedPositioned(
                        //   curve: Curves.decelerate,
                        //   duration: const Duration(milliseconds: 300),
                        //   top: 117.h,
                        //   left: startAnimation ? 36.w : 6.w,
                        //   child: MySearchWidget(
                        //     color: my_green,
                        //     myWidth: 303,
                        //     onSearch: (searchText) {},
                        //     iconWidget: SvgPicture.asset('icons/settings.svg'),
                        //     hintText:
                        //         'Cherchez un plat ou restaurant ou type de cuisine',
                        //   ),
                        // ),
                        Positioned(
                          top: 331.6.h,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 45.43.h,
                                width: 150.59.w,
                                child: SvgPicture.asset(
                                  'icons/voiture.svg',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Nous ne sommes pas encore là',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 36.w, right: 35.w),
                                child: Text(
                                  "Mais on y travaille! Nous pouvons vous envoyer un",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xff767676),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "e-mail dés que nous serons présents dans cette zone",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff767676),
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.black,
                  body: Stack(
                    children: [
                      SizedBox(
                          height: getHeight(context), width: getWidth(context)),
                      SizedBox(
                        height: getHeight(context),
                        width: getWidth(context),
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(widget.lat!, widget.lng!),
                            zoom: 12,
                          ),
                          // polylines: {polyline},
                          markers: _markers
                          //markerTwo,
                          ,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                      Container(
                        height: widget.fromMenu ? 462.h : 30.h,
                        color: widget.fromMenu ? Colors.white : Colors.black,
                        child: null,
                      ),
                      Positioned(
                        top: 15.h,
                        child: IndicContainerWidget(
                          texte: "Les stations proches",
                          fromMenu: true,
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
              );
  }

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final lat = place['lat'];
    final lng = place['lng'];

    final GoogleMapController controller = await _controller.future;
    setState(() {
      myLat = lat;
      myLng = lng;
    });

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16,
        ),
      ),
    );
  }
}
