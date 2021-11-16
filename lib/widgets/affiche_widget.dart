import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/five_stars_widget.dart';

class AfficheWidget extends StatelessWidget {
  final int avis;
  AfficheWidget({@required this.avis});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: myPhoneHeight(context) / 5.5,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'Burger King',
                        style: bold,
                      ),
                    ),
                    SizedBox(
                      width: myPhoneWidth(context) - 220,
                    ),
                    // cette widget ce trouve dans le fichier five_stars_widget.dart
                    FiveStarsWidget(
                      yellowStar: 4, // max 5 star ( 0 <= yellowStar < 6)
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                        width: 200,
                        child: Text('Fast Food/ Deserts/ Sandwich')),
                    SizedBox(
                      width: myPhoneWidth(context) - 320,
                    ),
                    Text('$avis avis'),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('8 rue cainin'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
