import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/screens/Mes%20commandes/commande_repo.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/center_footer_widget.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/footer_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:food_line/widgets/panier_details_widget.dart';
import 'package:food_line/widgets/somme_totale_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final commandeProvider = ChangeNotifierProvider<CommandeNotifier>(
  (ref) => CommandeNotifier(),
);

class PanierScreen extends ConsumerStatefulWidget {
  final String? idCmd;
  const PanierScreen({Key? key, this.idCmd}) : super(key: key);

  @override
  _PanierScreenState createState() => _PanierScreenState();
}

class _PanierScreenState extends ConsumerState<PanierScreen> {
  getDetais() {
    var viewmodel = ref.read(commandeProvider);
    viewmodel.detailsCommandeMenu(widget.idCmd!, context).then((value) {
      setState(() {
        isLoading = false;
        itemLength = viewmodel
                .detailsCmdMenu?.detailsCommande?.listeMenusCommande?.length ??
            0;
        print("priiiiiiice======>");
        print(viewmodel.detailsCmdMenu?.detailsCommande?.totalTtc);
        //  numCmd = viewmodel.detailsCmdMenu?[0].numeroCommande.toString();
      });
    });
  }

  getPanier() async {
    final viewModel = ref.read(panierProvider);
    await viewModel.getPanier(context).then(
      (value) {
        setState(() {
          //  itemLength = viewModel.listPanier?[0].listeMenus?.length ?? 0;
        });
      },
    );
    setState(() {});
  }

  bool isLoading = true;

  String? anonyme;
  void initState() {
    super.initState();
    getIdAnonyme();
    getDetais();
  }

  getIdAnonyme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    anonyme = prefs.getString(nonCo);
  }

  int itemLength = 0;
  bool goToMenu = false;
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(commandeProvider);

    return Consumer(builder: (context, watch, child) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 40.h,
                left: 32.w,
                child: Row(
                  children: [
                    MyWidgetButton(
                        widget: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      width: 45.w,
                    ),
                    Text(
                      'Détails de la commande',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: my_green,
                          fontWeight: FontWeight.bold),
                    ),

                    // MyWidgetButton(
                    //     widget: Center(
                    //       child: SvgPicture.asset('icons/panier_icon.svg'),
                    //     ),
                    //     onTap: () {}),
                  ],
                ),
              ),
              Positioned(
                bottom: 27.h,
                left: 90.w,
                child: QrImage(
                  data: widget.idCmd!,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              Positioned(
                  top: 117.h,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 75.h * 4,
                          width: getWidth(context),
                          child: ListView.builder(
                            itemCount: viewModel.detailsCmdMenu?.detailsCommande
                                    ?.listeMenusCommande?.length ??
                                0
                            //viewModel.detailsCmd?[0].results?[0]
                            // .listeMenusCommande?.length ??
                            // 0
                            ,
                            itemBuilder: (context, index) => Column(
                              children: [
                                PanierDetailWidget(
                                  image: viewModel
                                          .detailsCmdMenu
                                          ?.detailsCommande
                                          ?.listeMenusCommande?[index]
                                          .logoResto ??
                                      "",
                                  isHistorique: true,
                                  idpanier: viewModel
                                          .detailsCmdMenu
                                          ?.detailsCommande
                                          ?.listeMenusCommande?[index]
                                          .identifiant ??
                                      "",
                                  id: viewModel
                                          .detailsCmdMenu
                                          ?.detailsCommande
                                          ?.listeMenusCommande?[index]
                                          .identifiant ??
                                      "",
                                  xFood: viewModel
                                          .detailsCmdMenu
                                          ?.detailsCommande
                                          ?.listeMenusCommande?[index]
                                          .quantite ??
                                      0,
                                  menuText: viewModel
                                          .detailsCmdMenu
                                          ?.detailsCommande
                                          ?.listeMenusCommande?[index]
                                          .linkedMenu?[0]
                                          .titre ??
                                      "",
                                  supplement: viewModel
                                          .detailsCmdMenu
                                          ?.detailsCommande
                                          ?.listeMenusCommande?[index]
                                          .description ??
                                      "",
                                ),
                                SizedBox(
                                  height: 17.h,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 36.w,
                            ),
                            shrinkWrap: true,
                          ),
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        SommeTotaleWidget(
                          sousTotal: viewModel
                                  .detailsCmdMenu?.detailsCommande?.totalTtc ??
                              0.0,
                          fraisLivraison: 0,
                          fraisService: 0,
                        ),
                      ],
                    ),
                  )),
              // Positioned(
              //   bottom: 149.h,
              //   left: 36.w,
              //   child: MyWidgetButton(
              //     widget: CommanderWidget(
              //       titleLeftPadding: 41,
              //       priceLeftPadding: 24,
              //       myPrice: '${viewModel.listPanier?[0].prixTtc}€',
              //     ),
              //     onTap: () {
              //       anonyme == "false"
              //           ? Navigator.pushNamed(
              //               context, '/location_command_screen')
              //           : showDialog(
              //               context: context,
              //               builder: (context) {
              //                 return BackdropFilter(
              //                     filter:
              //                         ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              //                     child: Container(
              //                       alignment: Alignment.center,
              //                       //padding: EdgeInsets.only(bottom: 230),
              //                       color: Color(0xFFAEA9A3).withOpacity(0.2),
              //                       child: AlertDialog(
              //                         scrollable: true,
              //                         backgroundColor: Colors.white,
              //                         shape: RoundedRectangleBorder(
              //                           borderRadius:
              //                               BorderRadius.circular(10.0),
              //                         ),
              //                         content: Container(
              //                             constraints:
              //                                 BoxConstraints(minHeight: 150.0),
              //                             //height: 200.h,
              //                             width: 200.w,
              //                             //padding: ,
              //                             child: Column(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.center,
              //                               children: [
              //                                 Row(
              //                                   children: [
              //                                     SizedBox(width: 170.w),
              //                                     IconButton(
              //                                       onPressed: () {
              //                                         Navigator.of(context)
              //                                             .pop();
              //                                       },
              //                                       icon: const Icon(
              //                                         Icons.close,
              //                                         size: 20,
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   height: 20.h,
              //                                 ),
              //                                 Container(
              //                                   child: Text(
              //                                       "Voulez-vous continuez votre procédure de commande?",
              //                                       textAlign: TextAlign.center,
              //                                       style: TextStyle(
              //                                           color: my_green,
              //                                           fontSize: 14.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500)),
              //                                 ),
              //                                 SizedBox(
              //                                   height: 20.h,
              //                                 ),
              //                                 Container(
              //                                   child: Text(
              //                                       "Veuillez vous connecter!",
              //                                       textAlign: TextAlign.center,
              //                                       style: TextStyle(
              //                                         color: my_black,
              //                                         fontSize: 12.sp,
              //                                       )),
              //                                 ),
              //                                 Container(
              //                                   padding:
              //                                       EdgeInsets.only(top: 50),
              //                                   child: Row(
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment
              //                                             .spaceAround,
              //                                     children: [
              //                                       Container(
              //                                         height: 40.h,
              //                                         width: 100.w,
              //                                         child: RaisedButton(
              //                                           elevation: 0.0,
              //                                           color: my_green,
              //                                           shape:
              //                                               RoundedRectangleBorder(
              //                                             borderRadius:
              //                                                 BorderRadius
              //                                                     .circular(
              //                                                         10.0),
              //                                           ),
              //                                           onPressed: () {
              //                                             //  press();
              //                                             Navigator.pushNamed(
              //                                                 context,
              //                                                 '/login');
              //                                             //FadeTransition(opacity: , child: child);
              //                                           },
              //                                           child: Text("OK",
              //                                               style: TextStyle(
              //                                                   color: my_white,
              //                                                   fontSize: 12.sp,
              //                                                   fontFamily:
              //                                                       "Roboto")),
              //                                         ),
              //                                       ),
              //                                     ],
              //                                   ),
              //                                 ),
              //                               ],
              //                             )),
              //                       ),
              //                     ));
              //               }); //Navigator.pushNamed(context, '/login');
              //     },
              //     color: my_black,
              //     width: 303,
              //     height: 50,
              //   ),
              // ),
              // MyFooterWidget(
              //   taped: (i) {
              //     if (i == 1) {}
              //   },
              //   isAcceuil: false,
              //   isPanier: true,
              //   isProfile: false,
              // ),
              // CenterFooterWidget(
              //   isPanier: true,
              //   home: false,
              //   goToMenu: goToMenu,
              //   onPanier: () {},
              // ),
            ],
          ),
        ),
      );
    });
  }
}
