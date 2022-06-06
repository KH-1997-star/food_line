import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PanierRestantsWidget extends StatelessWidget {
  int nombrePanier;
  int? qtMax;
  int? qtRest;
  PanierRestantsWidget(
      {required this.nombrePanier, this.qtMax, this.qtRest, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 32.h,
      child: Column(
        children: [
          SizedBox(
            height: 6.h,
          ),
          Text(
            '$qtRest menus restants',
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Stack(
            children: [
              Container(
                height: 4.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: Color(0xff767676),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              Container(
                height: 4.h,
                width: (70 / (qtMax! / qtRest!)).w,
                decoration: BoxDecoration(
                  color: my_green,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
