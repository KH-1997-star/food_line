import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterFooterWidget extends StatefulWidget {
  final VoidCallback onPanier;
  final bool home;
  final bool goToMenu;
  final bool isPanier;
  const CenterFooterWidget(
      {required this.onPanier,
      this.home = false,
      this.isPanier = false,
      this.goToMenu = false,
      Key? key})
      : super(key: key);

  @override
  State<CenterFooterWidget> createState() => _CenterFooterWidgetState();
}

class _CenterFooterWidgetState extends State<CenterFooterWidget> {
  bool isPnaier = false;
  late bool goToMenu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToMenu = widget.goToMenu;

    Timer(const Duration(milliseconds: 50), () {
      if (widget.isPanier) {
        setState(() {
          isPnaier = true;
        });
      }
    });
    Timer(const Duration(milliseconds: 100), () {
      if (widget.goToMenu) {
        setState(() {
          goToMenu = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isPnaier ? 52.5.h : 45.5.h),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            widget.onPanier();
          },
          child: goToMenu
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.center,
                  height: goToMenu ? 74.28.h : 50.h,
                  width: goToMenu ? 75.92.w : 51.w,
                  child: SvgPicture.asset(
                    'icons/Cart.svg',
                    height: !goToMenu ? 22.h : 32.98.h,
                    width: !goToMenu ? 25.w : 37.48.w,
                  ),
                  decoration: BoxDecoration(
                    color: widget.home ? my_green : my_black,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                )
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.center,
                  height: isPnaier ? 74.28.h : 50.h,
                  width: isPnaier ? 75.92.w : 51.w,
                  child: SvgPicture.asset(
                    'icons/Cart.svg',
                    height: !isPnaier ? 22.h : 32.98.h,
                    width: !isPnaier ? 25.w : 37.48.w,
                  ),
                  decoration: BoxDecoration(
                    color: widget.home ? my_green : my_black,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
