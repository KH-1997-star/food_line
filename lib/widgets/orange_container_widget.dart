import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrangeContainer extends StatelessWidget {
  final double myHeight;
  final double myWidth;
  final Color myColor;
  final double myRadius;
  OrangeContainer({
    this.myHeight = 8,
    this.myWidth = 24,
    this.myColor = Colors.white,
    this.myRadius = 20,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: myWidth.w,
      height: myHeight.h,
      decoration: BoxDecoration(
        color: myColor,
        borderRadius: BorderRadius.all(
          Radius.circular(myRadius.r),
        ),
      ),
    );
  }
}
