import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/menuPage/profil_repo.dart';
import 'package:food_line/screens/testforlder/notification_screen_test.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/center_footer_widget.dart';
import 'package:food_line/widgets/footer_widget.dart';
import 'package:food_line/widgets/full_screen_widget.dart';
import 'package:food_line/widgets/menu_pages_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

import '../Panier/panier_screen.dart';

final signInModelSignIn = ChangeNotifierProvider<ProfileNotifier>(
  (ref) => ProfileNotifier(),
);

class MenuScreen extends ConsumerStatefulWidget {
  final bool fromHome;
  MenuScreen({
    Key? key,
    this.fromHome = false,
  }) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  bool startAnimation = false;
  void initState() {
    super.initState();
    getProfil();
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

  getProfil() async {
    final viewModel = ref.read(signInModelSignIn);
    await viewModel.getInfoClient(context).then((value) {
      email = value?.email ?? "";
      name = value?.nom ?? "";
      print(name);
      setState(() {
        isloading = false;
      });
      Timer(const Duration(milliseconds: 50), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
        return false;
      },
      child: Scaffold(
        body: isloading
            ? Container(
                child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: LoadingIndicator(
                    color: my_green,
                    indicatorType: Indicator.ballRotateChase,
                  ),
                ),
              ))
            : Stack(
                children: [
                  FullScreenForStackWidget(),
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
                          child: LocationCommand(),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                        ),
                      );
                    },
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.ease,
                    top: 109.h,
                    left: startAnimation ? 36.w : -250.w,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 75.h,
                            width: 75.w,
                            child: CircleAvatar(
                              backgroundColor: Colors.brown.shade800,
                            ),
                          ),
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
                                  child: Text(name!,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600))),
                              Container(
                                  height: 25.h,
                                  width: 250.w,
                                  alignment: Alignment.topLeft,
                                  child: Text(email!,
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
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.ease,
                    top: 243,
                    left: startAnimation ? 36.w : -350.w,
                    right: 36.w,
                    child: MenuPages(),
                  ),
                ],
              ),
      ),
    );
  }
}
