import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/my_app_bar_widget.dart';
import 'package:food_line/widgets/time_buttons.dart';

class TimeChooseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBarWidget(
              myLeftPadding: 0,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text(
                  'Souhaitez-vous être livrer',
                  style: semiBold,
                ),
                SizedBox(
                  width: 20,
                ),
                Image.asset('assets/images/clock.png'),
              ],
            ),
            Row(
              children: [
                Text(
                  'MIDI ou SOIR ou NUIT',
                  style: semiBold,
                ),
              ],
            ),
            SizedBox(
              height: myPhoneHeight(context) / 5,
            ),
            //le code de cette widget ce trouve dans le fichier time_buttons.dart
            Center(
              child: TimeButton(
                myColor: Colors.grey[500],
                time: 'Midi',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: TimeButton(
                myColor: Colors.grey[300],
                time: 'Soir',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: TimeButton(
                myColor: Colors.grey[500],
                time: 'Nuit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
