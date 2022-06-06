import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';

class AcueilWidget extends StatelessWidget {
  final bool enabled;
  final VoidCallback onAccueil;
  const AcueilWidget({required this.enabled, required this.onAccueil, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onAccueil();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 21.89.h,
            width: 18.71.w,
            child: enabled
                ? SvgPicture.asset(
                    'icons/Home.svg',
                    fit: BoxFit.contain,
                  )
                : SvgPicture.asset(
                    'icons/home_grey.svg',
                    fit: BoxFit.contain,
                  ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            'Accueil',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: enabled ? Colors.black : myLightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
