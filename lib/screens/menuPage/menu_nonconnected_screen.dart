import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/login/login_screen.dart';
import 'package:food_line/screens/menuPage/profil_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:food_line/widgets/center_footer_widget.dart';
import 'package:food_line/widgets/footer_widget.dart';
import 'package:food_line/widgets/menu_pages_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Panier/panier_screen.dart';
import '../location_command_screen.dart';

class MenuScreenOffLine extends ConsumerStatefulWidget {
  final bool fromHome;
  MenuScreenOffLine({
    Key? key,
    this.fromHome = false,
  }) : super(key: key);

  @override
  MenuScreenOffLineState createState() => MenuScreenOffLineState();
}

class MenuScreenOffLineState extends ConsumerState<MenuScreenOffLine> {
  @override
  bool startAnimation = false;
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 50), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  bool isloading = true;
  String? name = "";
  String? email = "";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('disposed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.ease,
            top: 109.h,
            left: startAnimation ? 36.w : -250.w,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    width: 18.w,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 25.h,
                          width: 250.w,
                          alignment: Alignment.topLeft,
                          child: Text("Vous n'êtes pas connecté",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600))),
                      Container(
                          height: 50.h,
                          width: 250.w,
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Pour pouvoir passer vos commandes veuillez vous connecter",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13.sp,
                                  color: my_hint,
                                  fontWeight: FontWeight.normal))),
                    ],
                  )
                ],
              ),
            ),
          ),
          // AnimatedPositioned(
          //   duration: const Duration(milliseconds: 2500),
          //   curve: Curves.ease,
          //   top: 243,
          //   left: startAnimation ? 36.w : -350.w,
          //   right: 36.w,
          //   child: MenuPages(),
          // ),

          AnimatedPositioned(
              duration: const Duration(milliseconds: 1200),
              curve: Curves.ease,
              left: startAnimation ? 36.w : -250.w,
              top: 243,
              right: 36.w,
              child: InkWell(
                child: Container(
                    child: Text("Se connecter",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20.sp,
                            color: my_green,
                            fontWeight: FontWeight.bold))),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString(nonCo, "true");
                  Navigator.push(
                      context, CostumPageRoute(child: const LoginScreen()));
                },
              )),
          MyFooterWidget(
            taped: (i) {
              print(i);

              setState(() {
                startAnimation = false;
              });
            },
            isAcceuil: false,
            isPanier: false,
            isProfile: true,
          ),
          CenterFooterWidget(
            home: false,
            goToMenu: widget.fromHome ? false : true,
            onPanier: () {
              setState(() {
                startAnimation = false;
              });

              Navigator.push(
                context,
                PageTransition(
                  child: const LocationCommand(),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
