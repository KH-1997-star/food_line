import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/affiche_widget.dart';

class MyFirstAnimatedMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('1'),
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: double.infinity,
              height: myPhoneHeight(context) / 4,
              color: Colors.white,
            ),
            SizedBox(
              height: myPhoneHeight(context) / 4.2,
              width: double.infinity,
              child: FittedBox(
                child: Image.asset(
                  'assets/images/menu_food_one.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: myPhoneHeight(context) / 15,
                left: 28,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: myPhoneHeight(context) / 15,
                right: 28,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.white,
                    child: Image.asset('assets/images/Menu.png')),
              ),
            ),
          ],
        ),
        // cette widget ce trouve dans le fichier affiche_widget.dart
        AfficheWidget(
          avis: 10,
        ),
      ],
    );
  }
}
