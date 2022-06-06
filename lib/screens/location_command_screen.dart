import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line/screens/Panier/liste_station_screen.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/livraison_quand_repo.dart';
import 'package:food_line/screens/login/login_screen.dart';
import 'package:food_line/screens/menuPage/profil_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/full_screen_widget.dart';
import 'package:food_line/widgets/horaire_cmd_widget.dart';
import 'package:food_line/widgets/livrer_quand_widget.dart';
import 'package:food_line/widgets/localisation_enregistrer_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/panier_details_widget.dart';
import 'package:food_line/widgets/somme_totale_widget.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);
final profilProvider = ChangeNotifierProvider<ProfileNotifier>(
  (ref) => ProfileNotifier(),
);
final tempsLivProvider = ChangeNotifierProvider<TempsLivNotifier>(
  (ref) => TempsLivNotifier(),
);

class LocationCommand extends ConsumerStatefulWidget {
  final int? indexAdress;
  final String horaire;
  final bool isAnonyme;
  const LocationCommand(
      {Key? key,
      this.indexAdress = 0,
      this.isAnonyme = false,
      this.horaire = ""})
      : super(key: key);

  @override
  _LocationCommandState createState() => _LocationCommandState();
}

class _LocationCommandState extends ConsumerState<LocationCommand> {
  int itemLength = 0;

  bool startAnimation = false;
  List<bool> myList = [];
  List<double> position = [];
  String? horaire;
  bool isLoading = true;
  String? ville = "";
  String? adresse = "";
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 50.0);
  String? anonyme;
  // getListAdd() {
  //   var viewModel = ref.read(tempsLivProvider);
  //   viewModel.listeAdresseLivraison().then((value) {
  //     print("hello1");
  //     setState(() {
  //       print(widget.indexAdress);
  //       indexA = widget.indexAdress ?? 0;
  //       isLoading = false;
  //       itemLength = viewModel.listeadresse?.results?.length ?? 0;
  //       print("VILLLLLLLEEEE");
  //       print(viewModel.listeadresse?.results?[indexA].ville);
  //       ville = viewModel.listeadresse?.results?[indexA].ville ?? "";
  //       adresse = viewModel.listeadresse?.results?[indexA].addresse ?? "";
  //       print('KHAAAAAIIIIRRIII');
  //       print(viewModel.listeadresse?.results?[indexA].position?[0]);
  //       position
  //           .add(viewModel.listeadresse?.results?[indexA].position?[0] ?? 0);
  //       position
  //           .add(viewModel.listeadresse?.results?[indexA].position?[1] ?? 0);
  //       /* position
  //           .add(viewModel.listeadresse?.results?[indexA].position?[0] ?? ); */
  //       print("PRIIIINT=======>");
  //       print(viewModel.listeadresse?.results?[indexA].ville ?? "");
  //       print(ville! + adresse!);
  //     });
  //     for (int i = 0; i < itemLength; i += 1) {
  //       myList.add(false);
  //     }
  //   });
  // }

  getIdAnonyme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    anonyme = prefs.getString(nonCo);
  }

  String? idPanier;
  getPanier() async {
    final viewModel = ref.read(panierProvider);
    await viewModel.getPanier(context).then(
      (value) {
        setState(() {
          itemLength = viewModel.listPanier?[0].listeMenus?.length ?? 0;
          idPanier = viewModel.listPanier?[0].identifiant;
        });
      },
    );
    setState(() {});
  }

  String? heure;
  String? diff;
  bool depass = false;
  bool depassMidi = false;
  bool depassSoir = false;
  bool depassNuit = false;
  String? dayLiv;
  String? idAdd;
  var format = DateFormat("HH:mm");
  final currentTime = DateTime.now();
  getHoraire() async {
    var Timenow = DateFormat.Hm().format(currentTime);
    int nowInMinutes = currentTime.hour * 60 + currentTime.minute;
    print("heuuuure NWO  ${currentTime.hour}    ${nowInMinutes}    ");

    print(nowInMinutes);
    final viewModel = ref.read(profilProvider);
    final viewModelAdd = ref.read(panierProvider);

    await viewModel.getInfoClient(context).then(
      (value) {
        setState(() {
          dayLiv = value?.timeLivraison ?? "";

          print("iciiiiiiii dayLiv    $dayLiv");
          horaire = value?.tempsLivraison ?? "";
          if (horaire == "Midi") {
            heure = "11h";
            var heureMin = 660;
            if (heureMin < nowInMinutes) {
              depass = true;
              depassMidi = true;
            }

            // diff = print(diff);
          } else if (horaire == "Soir") {
            heure = "15h";
            var heureMin = 900;
            if (heureMin < nowInMinutes) {
              depass = true;
              depassSoir = true;
            }
          } else {
            heure = "17h";
            var heureMin = 1020;
            if (heureMin < nowInMinutes) {
              depass = true;
              depassNuit = true;
            }
          }

          viewModelAdd
              .getDefaultAdrress(value?.addresse, context)
              .then((valuead) {
            setState(() {
              print("ICIIIIIII Adressssseeeeeeeee");
              adresse = viewModelAdd.adresseSelected?[0].addresse;
              ville = viewModelAdd.adresseSelected?[0].ville;
              idAdd = viewModelAdd.adresseSelected?[0].identifiant;
              print(adresse);
              print(ville);
              position.add(viewModelAdd.adresseSelected?[0].position?[0] ?? 0);
              position.add(viewModelAdd.adresseSelected?[0].position?[1] ?? 0);
              isLoading = false;
            });
          });
        });
      },
    );
    setState(() {});
  }

  int indexA = 0;
  @override
  void initState() {
    getPanier();
    getHoraire();
    // getListAdd();
    getIdAnonyme();
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(milliseconds: 50),
      () => setState(
        () {
          startAnimation = true;
        },
      ),
    );
    for (int i = 0; i < itemLength; i += 1) {
      myList.add(false);
    }
    print(myList);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(panierProvider);
    final viewModelAdd = ref.read(tempsLivProvider);
    final viewModelA = ref.read(tempsLivProvider);

    print(myList);
    return Consumer(builder: (context, watch, child) {
      print("ADDDDDDDDDRESSSSE=====>");

      return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const FullScreenForStackWidget(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 36.h, horizontal: 36.w),
                          child: Row(
                            children: [
                              MyWidgetButton(
                                widget: myBackIcon,
                                onTap: () => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (Route<dynamic> route) => false),
                              ),
                              SizedBox(
                                width: 68.w,
                              ),
                              Text(
                                'Mon panier',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: my_green,
                                ),
                              )
                            ],
                          ),
                        ),

                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                          top: startAnimation ? 108.h : 1000.h,
                          left: 36.w,
                          right: 36.w,
                          child: isLoading == true
                              ? Container(
                                  color: Colors.white,
                                  height: 200.h,
                                )
                              : LocalisationEnregistrerWidget(
                                  // ispanier: false,
                                  id: idAdd,
                                  horaire: horaire,
                                  ville: ville!,
                                  address: adresse!,
                                  taped: () {},
                                  isTaped: false,
                                ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                          top: startAnimation ? 180.h : 1000.h,
                          left: 36.w,
                          right: 36.w,
                          child: HoraireCmdWidget(
                            dayLiv: dayLiv,
                            address: viewModelAdd
                                .listeadresse?.results?[indexA].identifiant,
                            horaire: dayLiv == "Tomorrow"
                                ? "Livraison du $horaire (Demain)  "
                                : depass
                                    ? "Horaire de commande dépassé"
                                    : "Livraison du $horaire (Avant $heure)  ",
                            taped: () {},
                            isTaped: false,
                            onChange: (v) {
                              print(v);
                              setState(() {
                                horaire = v;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          top: 267.8.h,
                          child: Container(
                            width: getWidth(context),
                            height: 40.h,
                            color: Colors.grey[100],
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 36.w,
                                ),
                                Text(
                                  'Mes produits',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                          top: startAnimation ? 328.8.h : 1000.h,
                          left: 0.w,
                          right: 0.w,
                          child: Scrollbar(
                            // isAlwaysShown: true,
                            // controller: _scrollController,
                            child: SizedBox(
                              height: 75.h * 3,
                              child: Center(
                                child: ListView.builder(
                                  itemCount: viewModel
                                          .listPanier?[0].listeMenus?.length ??
                                      0,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 36.w),
                                        child: PanierDetailWidget(
                                          image: viewModel
                                                  .listPanier?[0]
                                                  .listeMenus?[index]
                                                  .logoResto ??
                                              "",
                                          idpanier: viewModel
                                                  .listPanier?[0]
                                                  .listeMenus?[index]
                                                  .identifiant ??
                                              "",
                                          id: viewModel
                                                  .listPanier?[0]
                                                  .listeMenus?[index]
                                                  .linkedMenu?[0]
                                                  .identifiant ??
                                              "",
                                          xFood: viewModel
                                                  .listPanier?[0]
                                                  .listeMenus?[index]
                                                  .quantite ??
                                              0,
                                          menuText: viewModel
                                                  .listPanier?[0]
                                                  .listeMenus?[index]
                                                  .linkedMenu?[0]
                                                  .titre ??
                                              "",
                                          supplement: viewModel
                                                  .listPanier?[0]
                                                  .listeMenus?[index]
                                                  .description ??
                                              "",
                                        ),
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
                        Positioned(
                          top: 589.8.h,
                          child: SommeTotaleWidget(
                            sousTotal: viewModel.listPanier?[0].prixTtc ?? 0,
                            fraisLivraison: 0,
                            fraisService: 0,
                          ),
                        ),
                        // Positioned(
                        //   top: 608.h,
                        //   child: InkWell(
                        //     onTap: () => Navigator.pushNamed(
                        //         context, '/livreur_list_screen'),
                        //     child: Container(
                        //       width: getWidth(context),
                        //       height: 40.h,
                        //       color: Colors.grey[100],
                        //       child: Row(
                        //         children: [
                        //           SizedBox(
                        //             width: 36.w,
                        //           ),
                        //           Text(
                        //             'Vos livreurs',
                        //             style: TextStyle(
                        //               fontSize: 13.sp,
                        //               fontWeight: FontWeight.w800,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 224.5.w,
                        //           ),
                        //           const Icon(
                        //             Icons.arrow_forward_ios_rounded,
                        //             size: 20,
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 695.h),
                            child: MyWidgetButton(
                              color: my_black,
                              width: 303,
                              height: 50,
                              widget: CommanderWidget(
                                  titleLeftPadding: 41,
                                  priceLeftPadding: 24,
                                  myPrice:
                                      '${viewModel.listPanier?[0].prixTtc}'),
                              onTap: () async {
                                bool? isToday;
                                if (dayLiv == "Now") {
                                  isToday = true;
                                } else {
                                  isToday = false;
                                }
                                print("tesmmps depasséééééé $depass");
                                print("tesmmps depasséééééé $dayLiv");
                                bool isStation = await viewModel.getListStation(
                                    context, idAdd, horaire, idPanier, isToday);
                                print("heeeloooo station");
                                print(isStation);

                                if (anonyme == "false") {
                                  if (viewModel
                                          .listPanier?[0].listeMenus?.length ==
                                      0) {
                                    Toast.show("Le panier est vide", context,
                                        duration: 1,
                                        gravity: 1,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.5));
                                  } else if (isStation == false) {
                                    Toast.show(
                                        "Aucune station n'est disponible",
                                        context,
                                        duration: 1,
                                        gravity: 1,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.5));
                                  } else if (depass && dayLiv == "Now") {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: Container(
                                                alignment: Alignment.center,
                                                //padding: EdgeInsets.only(bottom: 230),
                                                color: Color(0xFFAEA9A3)
                                                    .withOpacity(0.2),
                                                child: AlertDialog(
                                                  scrollable: true,
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  content: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minHeight: 150.0),
                                                      //height: 200.h,
                                                      width: 200.w,
                                                      //padding: ,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 160.w),
                                                              IconButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.close,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                                "Merci de modifier vod horaires de livraison afin qu'on puisse vous livrer",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color:
                                                                        my_green,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ));
                                        });

                                    // Toast.show(
                                    //     "Horaire de livraison dépassé", context,
                                    //     duration: 1,
                                    //     gravity: 1,
                                    //     backgroundColor:
                                    //         Colors.grey.withOpacity(0.5));
                                  } else if (horaire == "") {
                                    Toast.show(
                                        "Veuillez sélectionner un horaire",
                                        context,
                                        duration: 1,
                                        gravity: 1,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.5));
                                  } else {
                                    viewModel.creatCommande(
                                        context,
                                        dayLiv,
                                        horaire,
                                        idAdd,
                                        viewModel.listPanier?[0].prixTtc
                                            .toString(),
                                        position);
                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     child: StationsScreen(
                                    //         type: horaire,
                                    //         idAd: viewModelAdd.listeadresse
                                    //             ?.results?[0].identifiant),
                                    //     type: PageTransitionType.fade,
                                    //     duration: const Duration(milliseconds: 500),
                                    //     //reverseDuration: const Duration(milliseconds: 1000),
                                    //   ),
                                    // );
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              alignment: Alignment.center,
                                              //padding: EdgeInsets.only(bottom: 230),
                                              color: Color(0xFFAEA9A3)
                                                  .withOpacity(0.2),
                                              child: AlertDialog(
                                                scrollable: true,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                content: Container(
                                                    constraints: BoxConstraints(
                                                        minHeight: 150.0),
                                                    //height: 200.h,
                                                    width: 200.w,
                                                    //padding: ,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 160.w),
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                Icons.close,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                              "Voulez-vous continuez votre procédure de commande?",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color:
                                                                      my_green,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                              "Veuillez vous connecter!",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: my_black,
                                                                fontSize: 12.sp,
                                                              )),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 50),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Container(
                                                                height: 40.h,
                                                                width: 100.w,
                                                                child:
                                                                    RaisedButton(
                                                                  elevation:
                                                                      0.0,
                                                                  color:
                                                                      my_green,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    //  press();
                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    prefs.setString(
                                                                        nonCo,
                                                                        "true");
                                                                    Navigator.push(
                                                                        context,
                                                                        CostumPageRoute(
                                                                            child:
                                                                                const LoginScreen()));
                                                                    //FadeTransition(opacity: , child: child);
                                                                  },
                                                                  child: Text(
                                                                      "OK",
                                                                      style: TextStyle(
                                                                          color:
                                                                              my_white,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontFamily:
                                                                              "Roboto")),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ));
                                      });
                                } //Navigator.pushNamed(context, '/login');
                              },

                              //   Navigator.pushNamed(context, '/stations'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
