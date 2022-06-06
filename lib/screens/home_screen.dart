import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/notification.dart';
import 'package:food_line/services/location_service.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/button_map_widgte.dart';
import 'package:food_line/widgets/center_footer_widget.dart';
import 'package:food_line/widgets/food_list_widget.dart';
import 'package:food_line/widgets/footer_widget.dart';
import 'package:food_line/widgets/little_plat_widget.dart';
import 'package:food_line/widgets/livrer_quand_widget.dart';
import 'package:food_line/widgets/locasearch_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:food_line/widgets/promotion_widget.dart';
import 'package:food_line/widgets/select_pos_widget.dart';
import 'package:food_line/widgets/titre_food_line_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'LocationLivreur/location_screen.dart';
import 'a_propos_screen.dart';
import 'listeresto_repo.dart';
import 'package:intl/intl.dart';

final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);
final restoProvider = ChangeNotifierProvider<RestoNotifier>(
  (ref) => RestoNotifier(),
);

class HomeScreen extends ConsumerStatefulWidget {
  final bool isFirstTime;
  const HomeScreen({this.isFirstTime = false, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool? checkedValue = false;
  List<bool> myList = [];
  List<String> mySpList = [];
  getPanier() async {
    final viewModel = ref.read(panierProvider);
    await viewModel.getPanier(context).then(
      (value) {
        setState(() {});
      },
    );
    setState(() {});
  }

  String temp = '';
  List<bool> clickedList = [false, false, false];
  void whichClicked(List<bool> l, int x, StateSetter setStat) {
    for (int i = 0; i < clickedList.length; i += 1) {
      if (x != i) {
        setStat(() {
          clickedList[i] = false;
        });
      } else {
        setStat(() {
          clickedList[i] = !clickedList[i];
        });
      }
    }
  }

  //var format = DateFormat("HH:mm");
  final currentTime = DateTime.now();

  String? horaire;
  String? heure;
  String? diff;
  bool depass = false;
  bool depassMidi = false;
  bool depassSoir = false;
  bool depassNuit = false;
  String? dayLiv;

  String? adresse, ville, idAdd;
  getAdress(String id) {
    final viewModelAdd = ref.read(panierProvider);

    viewModelAdd.getDefaultAdrress(id, context).then((valuead) {
      setState(() {
        adresse = viewModelAdd.adresseSelected?[0].addresse;
        ville = viewModelAdd.adresseSelected?[0].ville;
        idAdd = viewModelAdd.adresseSelected?[0].identifiant;
        isLoadingAd = false;
      });
    });
  }

  bool isLoadingAd = true;
  getHoraire() async {
    //var Timenow = DateFormat.Hm().format(currentTime);
    int nowInMinutes = currentTime.hour * 60 + currentTime.minute;
    //  print("heuuuure NWO  ${currentTime.hour}    ${nowInMinutes}    ");

    //  print(nowInMinutes);
    final viewModel = ref.read(profilProvider);
    await viewModel.getInfoClient(context).then(
      (value) {
        getAdress(value?.addresse);
        setState(() {
          dayLiv = value?.timeLivraison ?? "";

          // print("iciiiiiiii dayLiv    $dayLiv");
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
        });
      },
    );
    setState(() {
      isloading = false;
    });
  }

  bool isloading = true;
  String? idSpecialite;
  getListeSpecialite() async {
    final viewModel = ref.read(restoProvider);
    await viewModel.loadingListTags().then((value) {
      int len = viewModel.listtags?.results?.length ?? 0;
      //   print("lenght tags========>");
      //   print(viewModel.listtags?.results?.length);
      for (int i = 0; i < len; i += 1) {
        myList.add(false);
      }
    });
    setState(() {
      isloadingSp = false;
    });
  }

  bool isloadingSp = true;
  getListepromo() async {
    final viewModel = ref.read(restoProvider);
    await viewModel.loadingListPromos().then((value) {
      setState(() {
        //  print("lenght promo========>");
        //  print(viewModel.listePromo?.results?.length);
        isloading = false;
      });
    });
  }

  bool enablfield = false;
  getlistResto(String filter) async {
    final viewModel = ref.read(signInModelSignIn);

    await viewModel.listeResto(filter).then((value) {
      //  print("lenght resto========>");
      //  print(viewModel.listResto?.length);
    });
    getHoraire();
  }

  getlistRestoSearch(String filter) async {
    final viewModel = ref.read(signInModelSignIn);

    await viewModel.searchlisteResto(filter).then((value) {});
  }

  bool enableSearch = false;
  @override
  void initState() {
    getListeSpecialite();
    getListepromo();
    getPanier();
    getHoraire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(restoProvider);

    return viewModel.listePromo == null ||
            isloading ||
            viewModel.listtags == null
        ? Container(
            child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: LoadingIndicator(
                color: my_green,
                indicatorType: Indicator.ballRotateChase,
              ),
            ),
          ))
        : WillPopScope(
            onWillPop: () {
              exit(0);
            },
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: const Color(0xffFBFAFF),
                body: Stack(
                  children: [
                    Positioned(
                        top: 40.h,
                        right: 10.w,
                        child: ButtonMap(
                          onTap: () async {
                            await LocationService().getStationNumber(context);
                          },
                        )),
                    Positioned(
                        top: 0.h,
                        right: 0.w,
                        child: InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  PageTransition(
                                    child: AProposScreen(ishome: true),
                                    type: PageTransitionType.fade,
                                  ),
                                ),
                            child: Container(
                                height: 30.h,
                                width: 30.w,
                                child: Image.asset('icons/apropos.png')))),
                    Positioned(
                        top: 7.h, left: 128.w, child: const TitreFoodLine()),
                    Positioned(
                        top: 65.h,
                        left: 0.w,
                        child: Container(
                          height: 20.h,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.6.w),
                                child: SvgPicture.asset('icons/location.svg',
                                    height: 21.61.h,
                                    width: 14.53.w,
                                    color: my_green),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              isLoadingAd
                                  ? SizedBox()
                                  : Container(
                                      width: 100.w,
                                      child: Text(adresse!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                    ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 65.h,
                        left: 140.w,
                        child: InkWell(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                            height: 19.h,
                            child: Row(
                              children: [
                                Image.asset(
                                  'icons/horaire.png',
                                  height: 21.61.h,
                                  width: 14.53.w,
                                  color: !depass || dayLiv == "Tomorrow"
                                      ? my_green
                                      : Colors.red,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  dayLiv == "Tomorrow"
                                      ? " $horaire (Demain)  "
                                      : depass
                                          ? "Horaire dépassé"
                                          : "$horaire (Avant $heure)  ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: !depass || dayLiv == "Tomorrow"
                                          ? my_black
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                ),
                                Container(
                                  height: 20.h,
                                  child: SvgPicture.asset(
                                    'icons/edit.svg',
                                    color: !depass || dayLiv == "Tomorrow"
                                        ? my_black
                                        : Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Positioned(
                      child: AnimatedOpacity(
                          child: Container(child: Text('hellooooo')),
                          opacity: 0,
                          duration: const Duration(milliseconds: 300)),
                    ),

                    // Positioned(
                    //   top: 51.h,
                    //   child: SelectPositionWidget(
                    //     onSelectPos: () => Navigator.push(
                    //       context,
                    //       PageTransition(
                    //         child: LocationMenuScreen(
                    //           fromMenu: true,
                    //         ),
                    //         type: PageTransitionType.fade,
                    //         duration: const Duration(milliseconds: 500),
                    //         //reverseDuration: const Duration(milliseconds: 1000),
                    //       ),
                    //     ),
                    //     onNotif: () => Navigator.push(
                    //       context,
                    //       PageTransition(
                    //         child: const NotificationScreen(),
                    //         type: PageTransitionType.fade,
                    //         duration: const Duration(milliseconds: 800),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 55.h,
                    //   right: 36.w,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         PageTransition(
                    //           child: const NotificationScreen(),
                    //           type: PageTransitionType.fade,
                    //           duration: const Duration(milliseconds: 500),
                    //         ),
                    //       );
                    //     },
                    //     child: SvgPicture.asset(
                    //       'icons/notification.svg',
                    //       height: 24.h,
                    //       width: 19.5.w,
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: 102.h,
                      left: 6.w,
                      child: MySearchWidget(
                        onTap: (enable) {
                          if (enable) {
                            setState(() {
                              enableSearch = true;
                            });
                          }
                        },
                        color: Colors.transparent,
                        myWidth: 359,
                        onSearch: (searchText) {
                          print('FUCK YOU');
                          getlistRestoSearch(searchText);
                        },
                        iconWidget: Container(
                            height: 20.h,
                            width: 20.w,
                            child: enableSearch
                                ? Image.asset(
                                    'icons/validate.png',
                                  )
                                : SizedBox()),
                        hintText:
                            'Cherchez un plat ou restaurant ou type de cuisine',
                      ),
                    ),
                    Positioned(
                        top: 166.9.h,
                        left: 6.w,
                        child: LittlePlatWidget(
                          isTaped: true,
                          onChooseTag: (add) {
                            getlistResto("");
                            setState(() {
                              myList = unClick(
                                  -1, viewModel.listtags?.results?.length ?? 0);
                              mySpList.clear();
                            });
                          },
                          taped: () => setState(() {
                            getlistResto("");

                            myList = unClick(
                                -1, viewModel.listtags?.results?.length ?? 0);
                          }),
                          titrePlat: "Tous",
                          pathPlat: 'images/little_plat_zero.png',
                          local: true,
                        )),
                    isloadingSp
                        ? Positioned(
                            top: 166.9.h,
                            left: 66.w,
                            right: 0,
                            // bottom: 559.h,
                            child: SizedBox(
                              height: 55.h,
                            ))
                        : Positioned(
                            top: 166.9.h,
                            left: 66.w,
                            right: 0,
                            child: SizedBox(
                              height: 55.42.w,
                              child: ListView.separated(
                                separatorBuilder: (context, child) => Container(
                                  width: 5,
                                ),
                                itemBuilder: (context, index) {
                                  return LittlePlatWidget(
                                    onChooseTag: (add) {
                                      if (add) {
                                        setState(() {
                                          myList[index] = !myList[index];
                                          idSpecialite = viewModel
                                                  .listtags
                                                  ?.results?[index]
                                                  .identifiant ??
                                              "";
                                          mySpList.add(
                                              "specialiteRestos[in]=$idSpecialite");
                                          String stringList =
                                              mySpList.join("&");
                                          getlistResto("&$stringList");
                                        });
                                      } else {
                                        setState(() {
                                          myList[index] = !myList[index];
                                          idSpecialite = viewModel
                                                  .listtags
                                                  ?.results?[index]
                                                  .identifiant ??
                                              "";
                                          mySpList.remove(
                                              "specialiteRestos[in]=$idSpecialite");
                                          String stringList =
                                              mySpList.join("&");
                                        });
                                      }
                                    },
                                    isTaped: myList[index],
                                    taped: () => setState(() {
                                      idSpecialite = viewModel.listtags
                                              ?.results?[index].identifiant ??
                                          "";
                                      getlistResto(
                                          "?specialiteRestos[in]=$idSpecialite");
                                      myList = unClick(
                                          index,
                                          viewModel.listtags?.results?.length ??
                                              0);
                                    }),
                                    titrePlat: viewModel.listtags
                                            ?.results?[index].libelle ??
                                        "",
                                    pathPlat: viewModel
                                            .listtags?.results?[index].image ??
                                        "",
                                  );
                                },
                                itemCount:
                                    viewModel.listtags?.results?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                    Positioned(
                      top: 230.h,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 22.2.h,
                              ),
                              SizedBox(
                                height: 170.h,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        PromotionFoodWidget(
                                          myPath: viewModel
                                                  .listePromo
                                                  ?.results?[index]
                                                  .photoCouverture ??
                                              "",
                                          myUrl: viewModel.listePromo
                                                  ?.results?[index].link ??
                                              "",
                                        ),
                                        SizedBox(
                                          width: 8.5.w,
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount:
                                      viewModel.listePromo?.results?.length ??
                                          0,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              FoodListWidget(),
                              SizedBox(
                                height: 90.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MyFooterWidget(
                      isAcceuil: true,
                      isPanier: false,
                      isProfile: false,
                      taped: (i) {},
                    ),
                    CenterFooterWidget(
                      home: true,
                      onPanier: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: LocationCommand(),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                          ),
                        );
                      },
                    ),
                    widget.isFirstTime
                        ? BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          )
                        : const SizedBox(),
                    widget.isFirstTime
                        ? const Align(
                            alignment: Alignment.bottomCenter,
                            child: LivrerQuandWidget(),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
  }

  static Future<void> _showBottomSheet(BuildContext context) async {
    int? result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: LivrerQuandWidget(
            isUpdate: true,
          ),
        ),
      ),
    );
  }
}
