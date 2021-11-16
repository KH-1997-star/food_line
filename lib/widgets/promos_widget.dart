import 'package:flutter/material.dart';

class PromosWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 144,
      width: 500,
      child: ListView.builder(
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: Image.asset(
              'assets/images/promos.png',
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: 2,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
