import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';

class SelectPositionWidget extends StatelessWidget {
  final VoidCallback onNotif;
  final VoidCallback onSelectPos;
  const SelectPositionWidget({
    required this.onNotif,
    required this.onSelectPos,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 6.w,
        ),
        Image.asset(
          'icons/Location.png',
          height: 35.h,
          width: 35.w,
        ),
        SizedBox(
          width: 8.3.w,
        ),
        InkWell(
          onTap: () => onSelectPos(),
          child: Row(
            children: [
              Text(
                'Sélectionnez votre position',
                style: TextStyle(fontSize: 14.sp),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: my_green,
              )
            ],
          ),
        ),
      ],
    );
  }
}
