import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  bool getBig = false;
  late AnimationController _controller;
  late Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0, end: 0.35)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(_controller);

    _controller.forward();
    Timer(
      const Duration(milliseconds: 100),
      () {
        setState(
          () {
            getBig = true;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 44.h),
        child: Stack(
          children: [
            SizedBox(
              height: getHeight(context),
              width: getWidth(context),
            ),
            AnimatedPositioned(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 600),
              top: getBig ? 36.h : 750.h,
              left: 36.h,
              child: MyWidgetButton(
                widget: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: my_white,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              left: 158.w,
              top: 44.h,
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.decelerate,
              right: getBig ? 165.5.w : 0,
              top: getBig ? 317.4.h : 30.h,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: getBig ? 55 : 24.h,
                width: getBig ? 43.97 : 19.5.w,
                child: SvgPicture.asset(
                  'icons/notification_grey.svg',
                ),
              ),
            ),
            Positioned(
              top: 389.h,
              left: 97.5.w,
              child: Text(
                'Vous n’avez aucune notification',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xffAFAFAF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
