import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/GererProfil/gerer_profil_screen.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/livraison_quand_repo.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/menuPage/profil_repo.dart';
import 'package:food_line/services/location_service.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/indic_container_widget.dart';
import 'package:food_line/widgets/localisation_enregistrer_widget.dart';
import 'package:food_line/widgets/locasearch_widget.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'Panier/panier_repo.dart';
import 'location_command_screen.dart';

final tempsLivProvider = ChangeNotifierProvider<TempsLivNotifier>(
  (ref) => TempsLivNotifier(),
);
final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);
final profilProvider = ChangeNotifierProvider<ProfileNotifier>(
  (ref) => ProfileNotifier(),
);

class LocationScreen extends ConsumerStatefulWidget {
  final bool fromMenu;
  final String? horaire;
  final String? token;
  final String? id;
  final bool? isLogin;
  final bool? isNonAdress;
  const LocationScreen(
      {this.fromMenu = false,
      this.isLogin = false,
      this.isNonAdress = false,
      this.horaire = "",
      this.token = "",
      this.id = "",
      Key? key})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  int? itemLength;
  double myLat = 49.443232;
  double myLng = 1.099971;
  String myPlace = 'Rouan, France';
  String? ville = "Rouan";
  String? pays = "France";
  String? codePostal = "09700";
  String? adresse = "rue jeanne d'arc";
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(49.443232, 1.099971),
    zoom: 13,
  );
  @override
  void initState() {
    print("helllooooooooooooooooooooo ${widget.fromMenu}");
    if (widget.fromMenu) {
      getHoraire();
    }
    super.initState();
    print(widget.fromMenu);
  }

  String? horaire;
  getStations(String adress) async {
    print("hello");
    print(adress);
    final viewModel = ref.read(panierProvider);
    print(adress);
    print(widget.horaire);
    bool? isToday;
    if (dayLiv == "Now") {
      isToday = true;
    } else {
      isToday = false;
    }
    await viewModel
        .getListStation(context, adress, widget.horaire, null, isToday)
        .then((value) {
      print("KIKOIIIIIIIII");
      print(viewModel.listStations?.listeStations?.length);
      viewModel.listStations?.listeStations?.length == 0
          ? Toast.show("Pas de station à cette position", context,
              backgroundColor: Colors.red, duration: 3, gravity: 3)
          : TempsLivNotifier.setAdresseProfil(adress, context, true);
    });

    setState(() {});
  }

  String? heure;
  getHoraire() async {
    final viewModel = ref.read(profilProvider);
    final viewModelAdd = ref.read(panierProvider);

    await viewModel.getInfoClient(context).then(
      (value) {
        setState(() {
          horaire = value?.tempsLivraison ?? "";
          dayLiv = value?.timeLivraison ?? "";
          if (horaire == "Midi") {
            heure = "11h";
            var heureMin = 660;

            // diff = print(diff);
          } else if (horaire == "Soir") {
            heure = "15h";
            var heureMin = 900;
          } else {
            heure = "17h";
            var heureMin = 1020;
          }
          print("Horaire de livraisonnnn $horaire");
          viewModelAdd
              .getDefaultAdrress(value?.addresse, context)
              .then((valuead) {
            setState(() {
              print("ICIIIIIII Adressssseeeeeeeee");
              adresse = viewModelAdd.adresseSelected?[0].addresse;
              ville = viewModelAdd.adresseSelected?[0].ville;
              print(adresse);
              print(ville);
              getListAdd(viewModelAdd.adresseSelected?[0].identifiant ?? "");
            });
          });
        });
      },
    );
    setState(() {
      isLoadingHor = false;
    });
  }

  String? dayLiv;
  List<bool> isDefault = [];
  getListAdd(String id) {
    var viewModel = ref.read(tempsLivProvider);
    viewModel.listeAdresseLivraison().then((value) {
      print("hello1");
      setState(() {
        isLoading = false;
        itemLength = viewModel.listeadresse?.results?.length ?? 0;
      });
      for (int i = 0; i < itemLength!; i += 1) {
        if (viewModel.listeadresse?.results?[i].identifiant == id) {
          myList.add(true);
        } else {
          myList.add(false);
        }
      }
      isLoading = false;
      // getHoraire(myList);
    });
  }

  bool isLoadingHor = true;
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
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(tempsLivProvider);
    final panierModel = ref.read(panierProvider);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(height: getHeight(context), width: getWidth(context)),
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
              height: widget.fromMenu ? 462.h : 30.h,
              color: widget.fromMenu ? Colors.white : Colors.black,
              child: widget.fromMenu
                  ? Stack(
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
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            LocalisationEnregistrerWidget(
                                                id: viewModel
                                                        .listeadresse
                                                        ?.results?[index]
                                                        .identifiant ??
                                                    "",
                                                ispanier: true,
                                                horaire: widget.horaire,
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
                                                  setState(() {
                                                    indexSelected = index;

                                                    myList = unClick(
                                                        index, itemLength!);
                                                    print("WHHHHHHYYYYYYYY");
                                                    print(viewModel
                                                        .listeadresse
                                                        ?.results?[index]
                                                        .identifiant
                                                        .toString());
                                                    getStations(viewModel
                                                            .listeadresse
                                                            ?.results?[index]
                                                            .identifiant
                                                            .toString() ??
                                                        "");
                                                  });
                                                }),
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
                    )
                  : null,
            ),
            Positioned(
              top: 15.h,
              child: IndicContainerWidget(
                dayLiv: dayLiv,
                ispanier: true,
                adresse: viewModel
                        .listeadresse?.results?[indexSelected].identifiant
                        .toString() ??
                    "",
                panier: true,
                horaire: horaire,
                index: indexSelected,
                texte: widget.fromMenu
                    ? "Adresses enregistrées"
                    : "Indiquez votre position",
                fromMenu: widget.fromMenu,
              ),
            ),
            widget.fromMenu
                ? !isLoadingHor
                    ? Positioned(
                        top: 85.h,
                        left: 120.w,
                        child: Row(
                          children: [
                            Text("Horaire de livraison :",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                dayLiv! == "Tomorrow"
                                    ? "$horaire (demain)"
                                    : "$horaire ($heure)",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ))
                    : SizedBox()
                : SizedBox(),
            widget.fromMenu
                ? Positioned(
                    top: 430.h,
                    left: 36.w,
                    child: const Text("Ajouter une nouvelle adresse",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                : const SizedBox(),
            Positioned(
              top: widget.fromMenu ? 497.h : 123.h,
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
            Padding(
              padding: EdgeInsets.only(bottom: 36.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () async {
                    var checkStation =
                        await panierModel.checkStation("$lat", "$lng", context);
                    print(checkStation);
                    dynamic? idSet;
                    if (checkStation) {
                      if (widget.fromMenu) {
                        await TempsLivNotifier.setMyAdress(
                            lat,
                            lng,
                            adresse,
                            "codePostal",
                            myPlace,
                            widget.fromMenu,
                            context,
                            false,
                            widget.id);
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        print("helooooooodbbsnbf siidii");
                        print(widget.id);
                        if (widget.isLogin!) {
                          prefs.setString(idConst, widget.id!);
                          prefs.setString(tokenconst, widget.token!);
                        }
                        await TempsLivNotifier.setMyAdress(
                            lat,
                            lng,
                            adresse,
                            "codePostal",
                            myPlace,
                            widget.fromMenu,
                            context,
                            widget.isLogin!,
                            widget.id);
                      }
                    } else {
                      Toast.show(
                          "Nous ne sommes pas encore disponible à cette adress !",
                          context,
                          backgroundColor: Colors.red,
                          duration: 2,
                          gravity: 3);
                    }
// isSet==true ? TempsLivNotifier().setAdresseProfil()
//                     print("HI again");
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
                  child: MyTitleButton(
                    color: my_black,
                    title: 'Enregistrer',
                  ),
                ),
              ),
            ),
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
