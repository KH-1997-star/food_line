import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';

class TagMenuWidget extends StatelessWidget {
  final String? title;

  const TagMenuWidget({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title ?? "",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontSize: 11.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
