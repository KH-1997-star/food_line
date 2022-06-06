import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/locasearch_widget.dart';
import 'package:food_line/widgets/titre_food_line_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import 'notification.dart';

class LieuScreen extends StatefulWidget {
  const LieuScreen({Key? key}) : super(key: key);

  @override
  State<LieuScreen> createState() => _LieuScreenState();
}

class _LieuScreenState extends State<LieuScreen> {
  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 50), () {
      setState(
        () {
          startAnimation = true;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //TODO background
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
              Positioned(
                top: 77.h,
                left: 9.1.w,
                child: Row(
                  children: [
                    SizedBox(
                      width: 6.w,
                    ),
                    SvgPicture.asset(
                      'icons/voiture.svg',
                      height: 15.h,
                      width: 53.17.w,
                    ),
                    SizedBox(
                      width: 8.3.w,
                    ),
                    Row(
                      children: [
                        Text(
                          'Sélectionnez votre position',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: my_green,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 300),
                top: 117.h,
                left: startAnimation ? 36.w : 6.w,
                child: MySearchWidget(
                  color: my_green,
                  myWidth: 303,
                  onSearch: (searchText) {},
                  iconWidget: SvgPicture.asset('icons/settings.svg'),
                  hintText: 'Cherchez un plat ou restaurant ou type de cuisine',
                ),
              ),
              Positioned(
                top: 331.6.h,
                child: Column(
                  children: [
                    Container(
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
                      padding: EdgeInsets.only(left: 36.w, right: 35.w),
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
    );
  }
}
