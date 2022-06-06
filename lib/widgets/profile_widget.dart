import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';

class ProfileWidget extends StatelessWidget {
  final bool enabled;
  final VoidCallback onProfile;
  const ProfileWidget(
      {required this.enabled, required this.onProfile, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onProfile();
      },
      child: Column(
        children: [
          SizedBox(
            height: 22.h,
            width: 14.71.w,
            child: SvgPicture.asset(
              enabled ? 'icons/profile_black.svg' : 'icons/Profile.svg',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: enabled ? Colors.black : myLightGrey,
            ),
          )
        ],
      ),
    );
  }
}
