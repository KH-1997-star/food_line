import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line/utils/colors.dart';
import 'package:toast/toast.dart';

class HorizontalCounetrWidget extends StatefulWidget {
  final Function(int, bool)? myCounter;
  final int? qt;
  final Function? onTap;
  final String? linkedpdt;
  final String? linkedColor;
  final String? linkedTaille;
  final int? qtMax;
  final bool? ispanier;

  HorizontalCounetrWidget(
      {this.myCounter,
      this.qt,
      this.onTap,
      this.qtMax,
      this.ispanier = false,
      this.linkedTaille = "",
      this.linkedColor = "",
      this.linkedpdt});
  @override
  _HorizontalCounetrWidgetState createState() =>
      _HorizontalCounetrWidgetState();
}

class _HorizontalCounetrWidgetState extends State<HorizontalCounetrWidget> {
  int? x = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // x = int.parse(widget.qt);
    setState(() {
      x = widget.qt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (x! > 1) {
                  print("I AM INNNNNNNN $x");
                  x = x! - 1;

                  // widget.onTap();
                  // print("**************************HII************");
                  // print(widget.linkedpdt);
                  // print(x.toString());
                  // print(widget.linkedColor);
                  // print(widget.linkedTaille);
                }
              });
              return widget.myCounter!(x!, false);
            },
            child: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                ),
                color: my_white_grey,
                border: Border.all(
                  width: 0.5.w,
                  color: my_white_grey,
                ),
              ),
              child: Icon(
                Icons.remove,
                size: 20.w,
                color: my_black,
              ),
            ),
          ),
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: my_white,
              ),
            ),
            child: Center(
              child: Text(
                '$x',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                print("ixiiiiiiii  $x");
                print(widget.qtMax);
                print(widget.ispanier);
                //int y = widget.ispanier! ? 100000 : widget.qtMax!;
                // print(y);
                if (x! < widget.qtMax! || widget.ispanier!) {
                  x = x! + 1;
                  //widget.onTap();
                  print("**************************HII************");
                  //  print(widget.linkedpdt);
                  print(x.toString());
                  print(widget.linkedColor);
                  print(widget.linkedTaille);
                } else {
                  Toast.show(
                      "La capacité de commande pour ce réstaurant est maximale",
                      context,
                      duration: 3,
                      gravity: 1,
                      backgroundColor: Colors.grey.withOpacity(0.7));
                }
              });
              return widget.myCounter!(x!, true);
            },
            child: Container(
              height: 50.h,
              width: 50.w,
              child: Icon(
                Icons.add,
                size: 20.w,
                color: my_black,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: my_white_grey,
                border: Border.all(
                  width: 0.5,
                  color: my_white_grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
