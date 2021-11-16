import 'package:flutter/material.dart';
 
import 'package:food_line/utils/consts.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/grey_circular_container.dart';
import 'package:food_line/widgets/orange_container.dart';

class EtapesScreen extends StatefulWidget {
  @override
  _EtapesScreenState createState() => _EtapesScreenState();
}

class _EtapesScreenState extends State<EtapesScreen> {
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: myPhoneHeight(context) / 1.7,
              width: double.infinity,
              child: Image.asset(
                mySvgImages[x],
                fit: x == 2 ? BoxFit.contain : BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: myPhoneHeight(context) / 2.3,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  )
                ]),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 45),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            x == 0
                                //le code de cette widget ce trouve dans le fichier orange_container.dart
                                ? OrangeContainer()
                                //le code de cette widget ce trouve dans le fichier grey_circular_container.dart
                                : GreyCircularContainer(),
                            SizedBox(
                              width: 10,
                            ),
                            x == 1
                                ? OrangeContainer()
                                : GreyCircularContainer(),
                            SizedBox(
                              width: 10,
                            ),
                            x == 2
                                ? OrangeContainer()
                                : GreyCircularContainer(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            myQuotes[x],
                            style: TextStyle(
                              height: 1.7,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/time_choose_screen'),
                        child: Text(
                          'Passer',
                          style: TextStyle(
                            color: Color(0XFF89898A),
                            fontSize: 14,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 45,
                      width: 98,
                      color: Color(0xffFFC529),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (x < 2)
                              setState(() {
                                x += 1;
                              });
                            else
                              Navigator.pushNamed(
                                  context, '/time_choose_screen');
                          });
                        },
                        child: Text(
                          'Suivant',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
