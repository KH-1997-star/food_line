import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  final String? email;
  const LandingScreen({Key? key, this.email = "email"}) : super(key: key);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool logoStartAnimation = false;
  bool toTheLeft = false;
  String? code;
  String? _email;
  @override
  void initState() {
    super.initState();
    next();
    setState(() {
      if (widget.email != null) {
        _email = widget.email;
        print(_email);
        print("********************HERE ***************");
      }
    });
  }

  next() {
    Future.delayed(const Duration(seconds: 4), () async {
      print('****************************');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(tokenconst) ?? "";
      print("helllloooooo");
      print(token.toString());
      print(token);
      if (token != "") {
        //prin()
        print("entrreeeeeer");
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print("###################################");
        Navigator.pushNamed(context, "/login");
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
    //final viewModel = context.read(signInModelSignIn);
    Size size = MediaQuery.of(context).size;
    // Timer(
    //       Duration(milliseconds: 100),
    //       () => setState(() {
    //             logoStartAnimation = true;
    //           }));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: my_black,
        body: Stack(children: <Widget>[
          Positioned(
            top: 364.h,
            right: 131.w,
            child: SvgPicture.asset(
              "images/logo_food.svg",
              fit: BoxFit.fill,
            ),
          ),
        ]));
  }
}
