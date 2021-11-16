import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:food_line/widgets/grey_circular_container.dart';
import 'package:food_line/widgets/orange_container.dart';

class GlamYouApp extends StatefulWidget {
  @override
  _GlamYouAppState createState() => _GlamYouAppState();
}

class _GlamYouAppState extends State<GlamYouApp> {
  @override
  int myindex;
  @override
  void initState() {
    super.initState();
    myindex = 0;
  }

  Widget build(BuildContext context) {
    List myFashionImagesList = [
      'assets/images/fashion_three.jpg',
      'assets/images/fashion_two.jpg',
      'assets/images/fashion_one.jpg',
    ];

    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              onPageChanged: (i, o) {
                setState(() {
                  myindex = i;
                });
              },
              viewportFraction: 1,
              height: 600,
              autoPlay: true,
            ),
            itemCount: myFashionImagesList.length,
            itemBuilder: (context, i, ri) {
              return Image.asset(
                myFashionImagesList[i],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 360,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myindex == 0 ? OrangeContainer() : GreyCircularContainer(),
                SizedBox(
                  width: 10,
                ),
                myindex == 1 ? OrangeContainer() : GreyCircularContainer(),
                SizedBox(
                  width: 10,
                ),
                myindex == 2 ? OrangeContainer() : GreyCircularContainer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
