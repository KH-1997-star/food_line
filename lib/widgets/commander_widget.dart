import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommanderWidget extends StatelessWidget {
  final String title;
  final double titleLeftPadding;
  final double priceLeftPadding;

  final String myPrice;
  const CommanderWidget(
      {required this.myPrice,
      this.titleLeftPadding = 8,
      this.priceLeftPadding = 8,
      this.title = 'Commander',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(left: titleLeftPadding.w),
            child: Text(
              title,
              style: TextStyle(
                color: my_white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            height: 29.h,
            width: 1,
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: priceLeftPadding.w),
            child: Text(
              '${myPrice} €',
              style: TextStyle(
                color: my_white,
                fontSize: 14.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
