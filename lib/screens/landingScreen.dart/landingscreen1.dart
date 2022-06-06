import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/landingScreen.dart/landing_screen.dart';
import 'package:food_line/screens/login/login_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreenOne extends StatefulWidget {
  final String? email;
  const LandingScreenOne({Key? key, this.email = "email"}) : super(key: key);
  @override
  _LandingScreenOneState createState() => _LandingScreenOneState();
}

class _LandingScreenOneState extends State<LandingScreenOne> {
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool logoStartAnimation = false;
  bool toTheLeft = false;
  String? code;
  String? _email;
  @override
  void initState() {
    super.initState();

    setState(() {
      // if (widget.email != null) {
      //   _email = widget.email;
      //   print(_email);
      //   print("********************HERE ***************");

      next();
      //   }
    });
  }

  next() {
    Future.delayed(const Duration(seconds: 4), () async {
      print('****************************');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(tokenconst) ?? "";
      print("helllloooooo");
      print(token);
      print(token);
      if (token == "" || token == null) {
        Navigator.pushNamed(context, "/login");
        //prin()
        //  Navigator.pushReplacementNamed(context, '/home');

      } else {
        Navigator.pushNamed(context, "/home_screen");
      }
    });
  }

  @override
  void dispose() {
    newTextEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("images/splash.json", height: 160.h, width: 160.w)
            ],
          ),
        ),
      ),
    );
  }
}
