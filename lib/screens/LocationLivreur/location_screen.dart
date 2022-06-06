import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/LocationLivreur/livreur_location_map.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/livraison_quand_repo.dart';
import 'package:food_line/screens/menuPage/menu_screen.dart';
import 'package:food_line/services/location_service.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/indic_container_widget.dart';
import 'package:food_line/widgets/localisation_enregistrer_widget.dart';
import 'package:food_line/widgets/locasearch_widget.dart';
import 'package:food_line/widgets/menu_pages_widget.dart';
import 'package:food_line/widgets/my_locations.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

final tempsLivProvider = ChangeNotifierProvider<TempsLivNotifier>(
  (ref) => TempsLivNotifier(),
);

class LocationMenuScreen extends ConsumerStatefulWidget {
  final bool fromMenu;
  final String? id;
  final bool? isadd;
  const LocationMenuScreen(
      {this.fromMenu = false, this.id, this.isadd = true, Key? key})
      : super(key: key);

  @override
  _LocationMenuScreenState createState() => _LocationMenuScreenState();
}

class _LocationMenuScreenState extends ConsumerState<LocationMenuScreen> {
  int? itemLength;
  double myLat = 43.24252599999999;
  double myLng = 1.595405;

  String myPlace = 'Rouan, France';
  String? ville = "Rouan";
  String? pays = "France";
  String? codePostal = "09700";
  String? adresse = "rue jeanne d'arc";
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(48.8566, 2.3522),
    zoom: 13,
  );
  @override
  void initState() {
    getListAdd();
    super.initState();
  }

  getListAdd() {
    var viewModel = ref.read(tempsLivProvider);
    viewModel.listeAdresseLivraison().then((value) {
      print("hello1");
      setState(() {
        isLoading = false;
        itemLength = viewModel.listeadresse?.results?.length ?? 0;
      });
      for (int i = 0; i < itemLength!; i += 1) {
        myList.add(false);
      }
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
    final viewModel = ref.read(tempsLivProvider);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuScreen(
                fromHome: true,
              ),
            ));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: getHeight(context), width: getWidth(context)),
                    SizedBox(
                      height: getHeight(context),
                      width: getWidth(context),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        // polylines: {polyline},
                        markers: {
                          Marker(
                            markerId: const MarkerId('markerOne'),
                            infoWindow: const InfoWindow(title: 'markerOne'),
                            icon: BitmapDescriptor.defaultMarker,
                            position: LatLng(myLat, myLng),
                          ),
                          //markerTwo,
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    Container(
                      height: 462.h,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 115.h,
                            left: 0,
                            right: 0,
                            child: viewModel.listeadresse == null ||
                                    isLoading == true
                                ? Container(
                                    color: Colors.white,
                                    height: 200.h,
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 36.w),
                                    child: Scrollbar(
                                      // isAlwaysShown: true,
                                      child: SizedBox(
                                        height: itemLength! < 4
                                            ? 75.h * itemLength!
                                            : 75.h * 4,
                                        width: getWidth(context),
                                        child: ListView.builder(
                                          itemCount: itemLength,
                                          itemBuilder: (context, index) =>
                                              Column(
                                            children: [
                                              MyLocalisationEnregistrerWidget(
                                                id: viewModel
                                                        .listeadresse
                                                        ?.results?[index]
                                                        .identifiant ??
                                                    "",
                                                lat: viewModel
                                                        .listeadresse
                                                        ?.results?[index]
                                                        .position![0] ??
                                                    0.0,
                                                lng: viewModel
                                                        .listeadresse
                                                        ?.results?[index]
                                                        .position![1] ??
                                                    0.0,
                                                ville: viewModel
                                                        .listeadresse
                                                        ?.results?[index]
                                                        .ville ??
                                                    "",
                                                address: viewModel
                                                        .listeadresse
                                                        ?.results?[index]
                                                        .addresse
                                                        .toString() ??
                                                    "",
                                                isTaped: myList[index],
                                                taped: () {
                                                  Navigator.push(
                                                    context,
                                                    CostumPageRoute(
                                                      child: LocationLivreurScreen(
                                                          lat: viewModel
                                                                      .listeadresse
                                                                      ?.results?[
                                                                          index]
                                                                      .position![
                                                                  0] ??
                                                              0.0,
                                                          lng: viewModel
                                                                      .listeadresse
                                                                      ?.results?[
                                                                          index]
                                                                      .position![
                                                                  1] ??
                                                              0.0,
                                                          id: viewModel
                                                                  .listeadresse
                                                                  ?.results?[
                                                                      index]
                                                                  .identifiant
                                                                  .toString() ??
                                                              ""),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                            ],
                                          ),
                                          shrinkWrap: true,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 15.h,
                      child: const IndicContainerWidget(
                        texte: 'Adresses enregistrées',
                        fromMenu: true,
                      ),
                    ),
                    Positioned(
                      top: 430.h,
                      left: 36.w,
                      child: const Text("Ajouter une nouvelle adresse",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 497.h,
                      left: 36.w,
                      child: MySearchWidget(
                        color: my_green,
                        iconWidget: SvgPicture.asset(
                          'icons/locate_icon.svg',
                        ),
                        hintText: 'Cherchez...',
                        onSearch: (searchText) async {
                          hideKeyboard(context);
                          var result = await LocationService().getPlace(
                            searchText,
                          );
                          if (result['toast']) {
                            Toast.show(
                              result['result'],
                              context,
                              backgroundColor: Colors.red,
                              gravity: 1,
                              duration: 3,
                            );
                          } else {
                            print("ADRESSSSSSSSSSSE");
                            print(result['result']['lat']);
                            print(result['result']['lng']);
                            lng = result['result']['lng'];
                            lat = result['result']['lat'];
                            // ville = result['ville'];
                            adresse = result['adresse'];
                            // codePostal = result['codePostal'];
                            place = result['result'];
                            myPlace = result['adress'];

                            goToPlace(place);
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 80.h,
                      left: 38.w,
                      child: InkWell(
                        onTap: () {
                          widget.fromMenu
                              ? TempsLivNotifier.setMyAdress(
                                  lat,
                                  lng,
                                  adresse,
                                  "codePostal",
                                  myPlace,
                                  widget.fromMenu,
                                  context,
                                  widget.isadd,
                                  "")
                              : TempsLivNotifier.setMyAdress(
                                  lat,
                                  lng,
                                  adresse,
                                  "codePostal",
                                  myPlace,
                                  widget.fromMenu,
                                  context,
                                  widget.isadd,
                                  "");

                          print("HI again");
                          print("lng : $lng , lat : $lat");
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const HomeScreen(
                          //         isFirstTime: true,
                          //       ),
                          //     ),
                          //   );
                        },
                        child: const MyTitleButton(
                          color: my_black,
                          title: 'Enregistrer',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
