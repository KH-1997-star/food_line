// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTitleButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Color titleColor;
  final Color color;
  final bool border;
  final Color bordorColor;

  const MyTitleButton({
    this.color = my_black,
    this.height = 50,
    this.width = 303,
    this.title = '',
    this.border = false,
    this.bordorColor = my_black,
    this.titleColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13.r),
        border: border
            ? Border.all(
                color: bordorColor,
                width: 1,
              )
            : Border.all(
                width: 0,
                color: Colors.transparent,
              ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w800,
          fontSize: 15.sp,
        ),
      ),
    );
  }
}
