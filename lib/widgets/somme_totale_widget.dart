import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/functions.dart';

class SommeTotaleWidget extends StatelessWidget {
  final dynamic sousTotal;
  final dynamic fraisLivraison;
  final dynamic fraisService;
  const SommeTotaleWidget(
      {required this.fraisLivraison,
      required this.fraisService,
      required this.sousTotal,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94.h,
      width: getWidth(context),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 36.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sous-total',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Text(
                    'Frais de livraison ',
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Text(
                    'Frais de service',
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h, right: 39.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$sousTotal€',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Text('$fraisLivraison €', style: TextStyle(fontSize: 14.sp)),
                  SizedBox(
                    height: 9.h,
                  ),
                  Text('$fraisService €', style: TextStyle(fontSize: 14.sp)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
