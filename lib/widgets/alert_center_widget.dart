import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertCenterWidget extends StatelessWidget {
  final int index;
  final Widget longWidget;
  final Widget circleWidget;
  final List<String> txtList;
  const AlertCenterWidget({
    required this.index,
    required this.longWidget,
    required this.circleWidget,
    required this.txtList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      key: Key('$index'),
      child: Container(
        height: 150.h,
        width: 303.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white.withOpacity(0.71),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 13.h,
            ),
            Text(
              'Slide ${index + 1}',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              txtList[index],
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.pink,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 19.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                index == 0 ? longWidget : circleWidget,
                SizedBox(
                  width: 4.w,
                ),
                index == 1 ? longWidget : circleWidget,
                SizedBox(
                  width: 4.w,
                ),
                index == 2 ? longWidget : circleWidget,
                SizedBox(
                  width: 4.w,
                ),
                index == 3 ? longWidget : circleWidget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
