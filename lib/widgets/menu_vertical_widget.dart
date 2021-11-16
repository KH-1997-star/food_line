import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/utils/functions.dart';

class MenuVerticaleWidget extends StatelessWidget {
  final int i;
  MenuVerticaleWidget({@required this.i});
  final Map myMenuInfo = {
    'imagePathList': [
      'assets/images/menu_food_three.png',
      'assets/images/menu_food_four.png',
    ],
    'titleList': [
      'Club Healhy',
      'Pasta cosi',
    ],
    'subTitleList': [
      'Poulet /Healthy /salades',
      'Pasta /Italien/salades',
    ]
  };

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          Container(
            width: myPhoneWidth(context),
            child: Image.asset(
              myMenuInfo['imagePathList'][i],
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  myMenuInfo['titleList'][i],
                  style: semiBold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Row(
              children: [
                Text(
                  myMenuInfo['subTitleList'][i],
                  style: subsemiBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
