import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/DetailsPlat/detail_plat.dart';
import 'package:food_line/screens/Panier/panier_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/favori_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:food_line/widgets/voir_panier_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCategortScreen extends StatefulWidget {
  final String? id;
  const DetailCategortScreen({Key? key, this.id}) : super(key: key);

  @override
  _DetailCategortScreenState createState() => _DetailCategortScreenState();
}

class _DetailCategortScreenState extends State<DetailCategortScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool panierClicked = false;
  bool showPanier = false;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  List<Widget> myTabsOne = [
    Container(
        width: 93.w,
        height: 25.h,
        child: Center(
          child: Text(
            "Les bons ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
        )),
    Container(
        width: 93.w,
        height: 25.h,
        child: Center(
          child: Text(
            "Nouveautés",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
        )),
    Container(
        width: 93.w,
        height: 25.h,
        child: Center(
          child: Text(
            "Menu Veggi",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
        )),
    Container(
        width: 93.w,
        height: 25.h,
        child: Center(
          child: Text(
            "Menus",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
        )),
    Container(
        width: 93.w,
        height: 25.h,
        child: Center(
          child: Text(
            "Snacks",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
        )),
  ];
  List<Widget> tabs = [
    TabViewList(title: 'Tab1'),
    TabViewList(title: 'Tab2'),
    TabViewList(title: 'Tab3'),
    TabViewList(title: 'Tab3'),
    TabViewList(title: 'Tab3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Positioned.fill(
                        child: Image.asset(
                          "images/Background_image.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 36.h,
                        left: 36.w,
                        child: MyWidgetButton(
                          widget: Container(
                            child: SvgPicture.asset(
                              'images/arrowback.svg',
                              height: 3.h,
                              width: 3.w,
                              fit: BoxFit.none,
                            ),
                          ),
                          color: my_white,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      Positioned(
                        top: 36.h,
                        right: 36.w,
                        child: MyFavoritButton(
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
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                width: 300.w,
                                child: Text("Burger King",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 11.h,
                              ),
                              Container(
                                width: 300.w,
                                child: Row(
                                  children: [
                                    SvgPicture.asset("icons/star.svg"),
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
                                    // SvgPicture.asset("icons/timer.svg"),
                                    // SizedBox(
                                    //   width: 3.w,
                                    // ),
                                    // Text("20min-30min",
                                    //     style: TextStyle(
                                    //         fontFamily: "Roboto",
                                    //         fontSize: 10.sp,
                                    //         fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // Positioned(top: 250.h, child: Text("hello"))
                    ],
                  ),
                  bottom: TabBar(
                      padding: EdgeInsets.only(left: 50.w),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: EdgeInsets.symmetric(horizontal: 2),
                      isScrollable: true,
                      //dragStartBehavior: DragStartBehavior.start,
                      indicatorColor: Colors.white,
                      unselectedLabelColor: my_black,
                      controller: _tabController,
                      indicator: const BubbleTabIndicator(
                          indicatorHeight: 25.0,
                          indicatorColor: Colors.black,
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsets.all(10)),
                      tabs: myTabsOne
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
                widget: const CommanderWidget(
                  titleLeftPadding: 41,
                  priceLeftPadding: 40,
                  myPrice: '1',
                  title: 'Voir le panier',
                ),
                onTap: () {
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
                    onCommandClick: () => Navigator.pushNamed(context, '/home'),
                    onBackClick: () => setState(() {
                      showPanier = false;
                      panierClicked = false;
                    }),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}

class TabA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        separatorBuilder: (context, child) => Divider(
          height: 5,
        ),
        padding: EdgeInsets.all(0.0),
        itemCount: 30,
        itemBuilder: (context, i) {
          return Container(
            height: 100,
            width: double.infinity,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          );
        },
      ),
    );
  }
}

class TabViewList extends StatefulWidget {
  final String? title;
  TabViewList({this.title});
  _TabViewListState createState() => _TabViewListState();
}

class _TabViewListState extends State<TabViewList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 36.w),
      child: ListView.separated(
        separatorBuilder: (context, child) => SizedBox(
          height: 10.h,
        ),
        primary: true,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const DetailsPlatScreen(),
                  type: PageTransitionType.bottomToTop,
                  duration: const Duration(seconds: 2),
                  curve: Curves.decelerate,
                  reverseDuration: const Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              height: 91.h,
              width: 375.w,
              child: Row(
                children: [
                  Container(
                    width: 201.w,
                    child: Column(
                      children: [
                        Container(
                            width: 200.w,
                            child: Text("2 Menus +9 Kings Nuggets",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14.sp,
                                ))),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          width: 200.w,
                          child: Text("22.90€",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14.sp,
                              )),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                            "2 menus au choix parmi une sélection de menus phares Burger",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 12.sp,
                                color: my_hint))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 27.w,
                  ),
                  Image.asset(
                    'images/menuImage.png',
                    height: 60.h,
                    width: 90.w,
                    fit: BoxFit.none,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
