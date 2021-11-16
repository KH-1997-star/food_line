import 'package:flutter/material.dart';

class SuggestionWidget extends StatelessWidget {
  //TODO tike the 3 most wanted Plat from API
  final List theMostWantedFoodList;
  SuggestionWidget({this.theMostWantedFoodList});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 20),
            child: InkWell(
              onTap: () {},
              child: Text(
                theMostWantedFoodList[i],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
        itemCount: theMostWantedFoodList.length,
      ),
    );
  }
}
