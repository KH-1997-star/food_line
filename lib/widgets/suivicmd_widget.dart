import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SuivicmdWidget extends StatelessWidget {
  final String? idCmd;
  final String? numCmd;
  final String? position;

  const SuivicmdWidget({Key? key, this.idCmd, this.position, this.numCmd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 177.h,
      decoration: BoxDecoration(
          color: my_white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(25.r, 25.r),
            topRight: Radius.elliptical(25.r, 25.r),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 36.w,
          ),
          Image.asset("images/linelivreur.png"),
          SizedBox(
            width: 10.w,
          ),
          Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Container(
                width: 150.w,
                child: Text(
                  'Commande N°${numCmd ?? ""}',
                  style: TextStyle(
                      color: my_black,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 150.w,
                child: Text(
                  "",
                  //  '13min-15min',
                  style: TextStyle(
                      color: my_black,
                      fontFamily: "Roboto",
                      // fontWeight: FontWeight.w500,
                      fontSize: 11.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 150.w,
                child: Text(
                  position!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: my_black,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp),
                ),
              ),
            ],
          ),
          QrImage(
            data: idCmd ?? "",
            version: QrVersions.auto,
            size: 122.0,
          ),
          SizedBox(
            height: 10.w,
          ),
        ],
      ),
    );
  }
}
