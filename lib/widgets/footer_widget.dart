import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/menuPage/menu_nonconnected_screen.dart';
import 'package:food_line/screens/menuPage/menu_screen.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:food_line/widgets/acueil_widget.dart';
import 'package:food_line/widgets/profile_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFooterWidget extends StatefulWidget {
  final bool isAcceuil;
  final bool isProfile;
  final bool isPanier;
  final Function(int)? taped;
  const MyFooterWidget(
      {required this.isAcceuil,
      required this.isProfile,
      required this.isPanier,
      this.taped,
      Key? key})
      : super(key: key);

  @override
  State<MyFooterWidget> createState() => _MyFooterWidgetState();
}

class _MyFooterWidgetState extends State<MyFooterWidget> {
  late bool isAceuille;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAceuille = widget.isAcceuil;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -55,
      left: -60.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              width: 485.w,
              //height: 69,
              child: Image.asset(
                'images/Base.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 105.w,
              top: 88.h,
              child: AcueilWidget(
                onAccueil: () {
                  widget.taped!(0);

                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const HomeScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                enabled: isAceuille,
              ),
            ),
            Positioned(
              top: 88.h,
              left: 345.w,
              child: ProfileWidget(
                onProfile: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? offLine = prefs.getString(nonCo);
                  print("hellllllloooooooo     $offLine");
                  widget.taped!(1);
                  if (widget.isAcceuil) {
                    if (offLine == "true") {
                      Navigator.push(
                        context,
                        CostumPageRoute(
                            child: MenuScreenOffLine(), myDuration: 0),
                      );
                    } else {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: MenuScreen(
                            fromHome: true,
                          ),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                        ),
                      );
                    }
                  } else {
                    if (offLine == "true") {
                      Navigator.push(
                        context,
                        CostumPageRoute(
                            child: MenuScreenOffLine(), myDuration: 0),
                      );
                    } else {
                      Navigator.push(
                        context,
                        CostumPageRoute(child: MenuScreen(), myDuration: 0),
                      );
                    }
                  }
                },
                enabled: widget.isProfile,
              ),
            ),
            widget.isPanier
                ? const SizedBox()
                : Positioned(
                    top: 69.h,
                    left: isAceuille ? 83.w : 330.w,
                    child: Container(
                      width: 73.w,
                      height: 2.5.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ),
            // SizedBox(child: Image.asset(name),)
          ],
        ),
      ),
    );
  }
}
