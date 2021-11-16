import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/utils/my_colors.dart';
import 'package:food_line/widgets/plats_widget.dart';
import 'package:food_line/widgets/search_widget.dart';
import 'package:food_line/widgets/suggestion_widget.dart';

class TheSearchingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: myPhoneHeight(context) / 8,
        ),
        child: Column(
          
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchWidget(
                    hintText: 'rechercher votre plat.....',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/resto_screen');
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: theHintTextColor,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            PlatWidget(
              myPlatList: myBurgersMap,
            ),
            SuggestionWidget(
              theMostWantedFoodList: [
                'Pepperoni Pizza',
                'Cheese Pizza',
                'Margherita Pizza',
              ],
            ),
          ],
        ),
      ),
    );
  }
}
