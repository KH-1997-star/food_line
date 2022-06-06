import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/favori_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';

class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  get my_white => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('AppBar'),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Stack(
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
                    child: Image.asset(
                  "images/Background_image.png",
                  fit: BoxFit.cover,
                )),
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
                        borderRadius: BorderRadius.circular(20.0.r),
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
                                SvgPicture.asset("icons/timer.svg"),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text("20min-30min",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.square(140.0),
            child: TabBar(
              padding: EdgeInsets.only(left: 50.w),
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.symmetric(horizontal: 1),
              isScrollable: true,
              //dragStartBehavior: DragStartBehavior.start,
              indicatorColor: Colors.white,
              unselectedLabelColor: my_black,
              //  controller: _tabController,
              indicator: const BubbleTabIndicator(
                  indicatorHeight: 25.0,
                  indicatorColor: Colors.black,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.all(10)),
              tabs: [
                Icon(Icons.train),
                Icon(Icons.directions_bus),
                Icon(Icons.motorcycle)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
