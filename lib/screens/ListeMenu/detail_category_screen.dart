import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/DetailsPlat/detail_plat.dart';
import 'package:food_line/screens/ListeMenu/liste_menu_repo.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/Panier/panier_screen.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/testforlder/notification_screen_test.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/favori_widget.dart';
import 'package:food_line/widgets/menu_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:food_line/widgets/tags_menu_widget.dart';
import 'package:food_line/widgets/voir_panier_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

final menuProvider = ChangeNotifierProvider<MenuNotifier>(
  (ref) => MenuNotifier(),
);
final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);

class MenutScreen extends ConsumerStatefulWidget {
  final String? id;
  final String? img;
  final String? name;
  final int? numab;
  final bool? dispo;
  final bool? like;
  final int? qteRest;
  const MenutScreen(
      {Key? key,
      this.id,
      this.img,
      this.name,
      this.numab = 0,
      this.like,
      this.qteRest,
      this.dispo = true})
      : super(key: key);

  @override
  _MenutScreenState createState() => _MenutScreenState();
}

class _MenutScreenState extends ConsumerState<MenutScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool panierClicked = false;
  bool showPanier = false;
  @override
  void initState() {
    print("iciiiiii=====================>");
    print(widget.id);
    _tabController = TabController(
      initialIndex: 0,
      length: widget.numab ?? 0,
      vsync: this,
    );
    getListeMenu();

    super.initState();
    print(widget.dispo);
    widget.dispo! ? null : _showDialog();
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.only(bottom: 230),
                color: Color(0xFFAEA9A3).withOpacity(0.2),
                child: AlertDialog(
                  scrollable: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  content: Container(
                      constraints: BoxConstraints(minHeight: 250.0),
                      //height: 200.h,
                      width: 250.w,
                      //padding: ,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          ),
                          Image.asset(
                            'icons/warning.png',
                            height: 140.h,
                            width: 140.w,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Le nombre de commandes a dépassé sa limite pour ce restaurant, vous ne pouvez pas passer une commande. Pour pouvoir passer vos commandes, veuillez choisir un autre horaire de livraison ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )),
                ),
              ));
        });
  }

  late bool isloading = true;
  String? idSpecialite;
  getListeMenu() async {
    int numbre = 0;
    print("iciiiiii=====================>");
    print(widget.id);
    final viewModel = ref.read(menuProvider);
    final viewModelPanier = ref.read(panierProvider);
    await viewModelPanier.getPanier(context);
    await viewModel.listeMenu(widget.id).then((value) {
      print("myTabsOne=======================>");

      // print(viewModel.listMenu?.length);
      setState(() {
        numbre = viewModel.listMenu?.length ?? 0;

        for (int i = 0; i < numbre; i++) {
          int numSous = viewModel.listMenu?[i].listeMenus?.length ?? 0;
          myTabsOne.add(TagMenuWidget(
            title: viewModel.listMenu?[i].name ?? "",
          ));

          tabs.add(
            MenuWidget(
                idResto: widget.id,
                name: widget.name,
                numab: widget.numab,
                indexOne: i,
                id: widget.id,
                imagee: widget.img ?? "",
                dispo: widget.dispo!,
                like: widget.like,
                rest: widget.qteRest),
          );
        }
      });
    });
    isloading = false;
    print(myTabsOne);
  }

  List<Widget> myTabsOne = [];
  List<Widget> tabs = [];
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(menuProvider);
    final viewModelPanier = ref.watch(panierProvider);
    print("hhhhhhh");
    setState(() {
      _tabController = TabController(
        initialIndex: 0,
        length: widget.numab ?? 0,
        vsync: this,
      );
    });
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        return viewModel.listMenu == null || isloading
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
            : DefaultTabController(
                length: widget.numab ?? 0,
                child: Scaffold(
                  body: Stack(
                    children: [
                      NestedScrollView(
                        floatHeaderSlivers: false,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverAppBar(
                              automaticallyImplyLeading: false,
                              expandedHeight: 244.0.h,
                              floating: true,
                              pinned: true,
                              snap: true,
                              flexibleSpace: Stack(
                                children: <Widget>[
                                  // Positioned(
                                  //   top: 50.h,
                                  //   left: 3.w,
                                  //   child: Container(
                                  //       color: my_green,
                                  //       child: Center(
                                  //           child: SvgPicture.asset("icons/search_icon.svg"))),
                                  // ),
                                  Positioned.fill(
                                    child: Container(
                                      width: 116.0,
                                      height: 174.0,
                                      foregroundDecoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.white
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [0, 0, 0.2, 0.8],
                                        ),
                                      ),
                                      child: Image.network(
                                        widget.img ?? "",
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Container(
                                            color: Colors.black,
                                            alignment: Alignment.center,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //     child: Image.asset(
                                    //   "images/Background_image.png",
                                    //   fit: BoxFit.cover,
                                    // )
                                  ),
                                  Positioned(
                                    top: 36.h,
                                    left: 36.w,
                                    child: MyWidgetButton(
                                      widget: SvgPicture.asset(
                                        'images/arrowback.svg',
                                        height: 3.h,
                                        width: 3.w,
                                        fit: BoxFit.none,
                                      ),
                                      color: my_white,
                                      onTap: () => Navigator.pushNamed(
                                          context, "/home_screen"),
                                    ),
                                  ),
                                  Positioned(
                                    top: 36.h,
                                    right: 36.w,
                                    child: MyFavoritButton(
                                      selected: widget.like!,
                                      id: widget.id,
                                      widget: Container(),
                                      color: my_white,
                                    ),
                                  ),
                                  Positioned(
                                      top: 135.h,
                                      left: 20.w,
                                      child: Container(
                                        height: 81.h,
                                        width: 335.w,
                                        decoration: BoxDecoration(
                                          color: my_white_opacity_menu,
                                          borderRadius:
                                              BorderRadius.circular(20.0.r),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            SizedBox(
                                              width: 300.w,
                                              child: Text(widget.name ?? "",
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 24.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(
                                              height: 11.h,
                                            ),
                                            SizedBox(
                                              width: 300.w,
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "icons/star.svg"),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Text("(" + "3,2" + ")",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 12.sp,
                                                        color: my_yellow,
                                                      )),
                                                  SizedBox(
                                                    width: 18.w,
                                                  ),
                                                  // SvgPicture.asset(
                                                  //     "icons/timer.svg"),
                                                  // SizedBox(
                                                  //   width: 3.w,
                                                  // ),
                                                  // Text("20min-30min",
                                                  //     style: TextStyle(
                                                  //         fontFamily: "Roboto",
                                                  //         fontSize: 10.sp,
                                                  //         fontWeight:
                                                  //             FontWeight.bold)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  // Positioned(
                                  //   top: 250.h,
                                  //   // left: 10.w,
                                  //   child: Container(
                                  //       width: 40.w,
                                  //       color: my_white,
                                  //       child: Center(
                                  //           child: SvgPicture.asset(
                                  //               "icons/search_icon.svg"))),
                                  // ),
                                ],
                              ),
                              bottom: TabBar(
                                //  padding: EdgeInsets.only(left: 50.w),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                isScrollable: true,
                                // dragStartBehavior: DragStartBehavior.start,
                                indicatorColor: Colors.white,
                                unselectedLabelColor: my_black,
                                controller: _tabController,
                                indicator: const BubbleTabIndicator(
                                    indicatorHeight: 30.0,
                                    indicatorColor: Colors.black,
                                    tabBarIndicatorSize:
                                        TabBarIndicatorSize.tab,
                                    padding: EdgeInsets.all(10)),
                                tabs: myTabsOne.map((tab) => tab).toList(),
                                // tabs
                                //     .map((tab) => Tab(
                                //           child: Container(
                                //               width: 93.w,
                                //               child: Text(
                                //                 "Les bons plans",
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     fontFamily: 'Roboto',
                                //                     fontSize: 11.sp),
                                //                 textAlign: TextAlign.center,
                                //               )),
                                //         ))
                                //     .toList(),
                              ),
                            ),
                          ];
                        },
                        body: TabBarView(
                          controller: _tabController,
                          children: tabs.map((tab) => tab).toList(),
                        ),
                      ),
                      panierClicked
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 36.h),
                          child: MyWidgetButton(
                            widget: CommanderWidget(
                              titleLeftPadding: 41,
                              priceLeftPadding: 40,
                              myPrice: ref
                                  .read(panierProvider)
                                  .prix
                                  .toStringAsFixed(
                                      2), //"${viewModelPanier.prix}€",
                              title: 'Voir le panier',
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: const LocationCommand(),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate,
                                ),
                              ).then((value) {
                                viewModelPanier.getPanier(context);
                              });
                              // setState(() {
                              //   panierClicked = true;
                              //   Timer(
                              //     const Duration(milliseconds: 200),
                              //     () => setState(
                              //       () {
                              //         showPanier = true;
                              //       },
                              //     ),
                              //   );
                              // });
                            },
                            color: panierClicked ? my_green : my_black,
                            width: 303,
                            height: 50,
                          ),
                        ),
                      ),
                      showPanier
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: VoirPanierWidget(
                                onCommandClick: () => Navigator.pushNamed(
                                    context, '/location_command_screen'),
                                onBackClick: () => setState(() {
                                  showPanier = false;
                                  panierClicked = false;
                                }),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
