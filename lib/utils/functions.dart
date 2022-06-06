import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

double getHeight(context) => MediaQuery.of(context).size.height;

double getWidth(context) => MediaQuery.of(context).size.width;
Widget backGroundImageWidget(int index, List<String> imageList) => Container(
      key: Key('$index'),
      child: Image.asset(
        imageList[index],
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
Widget alertCenterWidget(int index, List<String> txtList, Widget longWidget,
        Widget circleWidget) =>
    Center(
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
Widget switchWidget(int index, bool isContainer, List<String> imageList,
    Widget longWidget, Widget circleWidget, List<String> txtList) {
  if (isContainer) {
    return Container(
      key: Key('$index'),
      child: Image.asset(
        imageList[index],
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  } else {
    return Center(
      key: Key('$index'),
      child: Container(
        height: 150.h,
        width: 303.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(10.r, 8.r)),
          color: Colors.white.withOpacity(0.71),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 29.w, left: 39.w),
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
      ),
    );
  }
}

void buildshowToast(String msg) => Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      fontSize: 2,
      backgroundColor: Colors.red,
    );
void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());
List<bool> unClick(int index, int length) {
  List<bool> myList = [];
  for (int i = 0; i < length; i++) {
    if (index == i) {
      myList.add(true);
    } else {
      myList.add(false);
    }
  }
  return myList;
}

showToast(String msg) => Fluttertoast.showToast(
      msg: msg,
    );
