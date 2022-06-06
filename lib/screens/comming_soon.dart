import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/full_screen_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';
import 'package:page_transition/page_transition.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  bool isRetour = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              top: isRetour ? 806.h : 36.h,
              left: 36.w,
              child: MyWidgetButton(
                color: isRetour ? my_white : my_green,
                widget: isRetour ? myGreenBackIcon : myBackIcon,
                onTap: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Container(
                height: 300.h,
                width: 300.w,
                child: Image.asset("images/ComingSoon.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center myGreenBackIcon = Center(
    child: SvgPicture.asset(
      'icons/back_icon.svg',
      height: 16.h,
      width: 16.w,
      color: my_black,
    ),
  );
}
