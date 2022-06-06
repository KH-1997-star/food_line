import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/alert_center_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/orange_container_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'location_screen.dart';

class SlideScreen extends StatefulWidget {
  const SlideScreen({Key? key}) : super(key: key);

  @override
  _SlideScreenState createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  List<String> imageList = [
    'images/slide_one.jpg',
    'images/slide_two.jpg',
    'images/slide_three.jpg',
    'images/slide_four.jpg',
  ];

  List<double> blurList = [9, 9, 6, 15];
  List<String> txtList = [
    'Commandez a l’avance jusqu’à 18h tous les jours et soyez livré à heure fixe le soir-même dans votre ville!',
    'Le transport est assuré dans une box électrique spéciale pour maintenir chaud ou froid vos commandes',
    'suivez les livreurs en temps réels grâce a la géolocalisation',
    'Tous vos restaurants préférés sont disponible!'
  ];

  int index = 0;
  Timer? timer, mainTimer;
  Widget? myBgWidget, myAlertCenterWidget;
  bool changeOpacity = false;
  Widget longWidget = OrangeContainer(
    myHeight: 8,
    myWidth: 25,
    myColor: my_green,
    myRadius: 6,
  );
  Widget circleWidget = Container(
    height: 8.w,
    width: 8.w,
    decoration: const BoxDecoration(
      color: Color(0xffB3E898),
      shape: BoxShape.circle,
    ),
  );

  @override
  void initState() {
    super.initState();
    myBgWidget = backGroundImageWidget(index, imageList);
    myAlertCenterWidget = AlertCenterWidget(
      index: index,
      longWidget: longWidget,
      circleWidget: circleWidget,
      txtList: txtList,
    );
    if (index == 0) {
      mainTimer = Timer(const Duration(milliseconds: 2500), () {
        setState(() {
          index += 1;
        });

        timer = Timer.periodic(const Duration(milliseconds: 5000), (timer) {
          if (index < 3) {
            setState(() {
              index += 1;
            });
          } else {
            timer.cancel();
            setState(() {
              changeOpacity = true;
            });
            Navigator.push(
              context,
              CostumPageRoute(
                child: const LocationScreen(),
                direction: AxisDirection.up,
                myDuration: 3000,
              ),
            );
          }
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      setState(() {
        myBgWidget = switchWidget(
            index, true, imageList, longWidget, circleWidget, txtList);
        myAlertCenterWidget = switchWidget(
            index, false, imageList, longWidget, circleWidget, txtList);
      });
    } else if (index == 2) {
      setState(() {
        myBgWidget = switchWidget(
            index, true, imageList, longWidget, circleWidget, txtList);
        myAlertCenterWidget = switchWidget(
            index, false, imageList, longWidget, circleWidget, txtList);
      });
    } else {
      setState(() {
        myBgWidget = switchWidget(
            index, true, imageList, longWidget, circleWidget, txtList);
        myAlertCenterWidget = switchWidget(
            index, false, imageList, longWidget, circleWidget, txtList);
      });
    }
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.black,
        body: Stack(
          children: [
            AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                duration: const Duration(milliseconds: 3000),
                child: myBgWidget),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurList[index],
                sigmaY: blurList[index],
              ),
              child: Container(
                color: index == 3
                    ? Colors.white.withOpacity(0)
                    : Colors.black.withOpacity(0.29),
              ),
            ),
            AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              duration: const Duration(milliseconds: 2000),
              child: myAlertCenterWidget,
            ),
            AnimatedOpacity(
              opacity: changeOpacity ? 1 : 0,
              duration: const Duration(milliseconds: 2800),
              child: Container(
                height: getHeight(context),
                width: getWidth(context),
                color: Colors.black,
              ),
            ),
            Positioned(
              top: 36.h,
              right: 36.w,
              child: AnimatedOpacity(
                opacity: changeOpacity ? 0 : 1,
                duration: const Duration(milliseconds: 2800),
                child: MyWidgetButton(
                  onTap: () {
                    timer?.cancel();
                    setState(() {
                      changeOpacity = true;
                    });
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const LocationScreen(),
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 3000,
                        ),
                      ),
                    );
                  },
                  color: Colors.white,
                  radius: 20,
                  height: 29,
                  width: 65,
                  widget: Center(
                    child: Text(
                      'Passer',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
