import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';

class SuiviCommandeLineWidget extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? status;

  SuiviCommandeLineWidget({this.title, this.subtitle, this.status});
  _SuiviCommandeLineWidgetState createState() =>
      _SuiviCommandeLineWidgetState();
}

class _SuiviCommandeLineWidgetState extends State<SuiviCommandeLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Row(
              children: [
                if (widget.status == "done") ...[
                  Container(
                      height: 8.h,
                      width: 8.w,
                      child: Image.asset(
                        "images/done.png",
                      )),
                ] else if (widget.status == "waiting") ...[
                  Container(
                      height: 10.h,
                      width: 10.w,
                      child: Image.asset("images/pasencore.png")),
                ] else if (widget.status == "inprogress") ...[
                  Container(
                      height: 12.h,
                      width: 12.w,
                      child: Image.asset("images/encours.png")),
                ],
                SizedBox(
                  width: 42.w,
                ),
                Container(
                  width: 230.w,
                  child: Text(widget.title!,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              width: 150.w,
              child: Text(widget.subtitle ?? "",
                  style: TextStyle(
                    color: my_hint,
                    fontFamily: "Roboto",
                    fontSize: 12.sp,
                  )),
            )
          ],
        ),
      ],
    );
  }
}
