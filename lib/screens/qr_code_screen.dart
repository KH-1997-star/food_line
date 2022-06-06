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
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  bool isRetour = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdCmd();
  }

  String? idCmdd;
  getIdCmd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("QR CODE======>");
    setState(() {
      idCmdd = prefs.getString(idCmd);
    });
    print(idCmdd);
  }

  @override
  Widget build(BuildContext context) {
    print(idCmdd);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              const FullScreenForStackWidget(),
              // AnimatedPositioned(
              //   duration: const Duration(milliseconds: 600),
              //   top: isRetour ? 806.h : 36.h,
              //   left: 36.w,
              //   child: MyWidgetButton(
              //     color: isRetour ? my_white : my_green,
              //     widget: isRetour ? myGreenBackIcon : myBackIcon,
              //     onTap: () => Navigator.pop(context),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 46.h),
              //   child: const Align(
              //     alignment: Alignment.topCenter,
              //     child: Text(
              //       'Burger King',
              //       style: TextStyle(
              //         color: my_green,
              //         fontFamily: 'Poppins',
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                top: 172.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 36.w),
                  child: Column(
                    children: [
                      QrImage(
                        data: idCmdd ?? "",
                        version: QrVersions.auto,
                        size: 150.0,
                      ),
                      // SvgPicture.asset(
                      //   'images/qr_image.svg',
                      //   height: 219.h,
                      //   width: 219.w,
                      // ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        'Merci',
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        'vous aurez besoin du QR code',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Segoe',
                        ),
                      ),
                      Text(
                        'pour confirmer la réception de votre commande',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Segoe',
                        ),
                      ),
                      SizedBox(
                        height: 49.h,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isRetour = true;
                          });
                          Timer(
                            const Duration(milliseconds: 600),
                            () => Navigator.pushNamed(
                              context,
                              '/home_screen',
                            ),
                          );
                        },
                        child: const MyTitleButton(
                          title: 'Retour à l’accueil',
                          color: my_white,
                          border: true,
                          titleColor: my_black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
