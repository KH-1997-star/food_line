import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitreFoodLine extends StatelessWidget {
  final double fSize;
  const TitreFoodLine({this.fSize = 36, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Food',
          style: TextStyle(
            fontSize: fSize.sp,
            fontFamily: 'Amaranth',
          ),
        ),
        Text(
          'Line',
          style: TextStyle(
            fontSize: fSize.sp,
            color: my_green,
            fontFamily: 'Amaranth',
          ),
        )
      ],
    );
  }
}
