import 'package:flutter/material.dart';

class MyAppBarWidget extends StatelessWidget {
  final double myLeftPadding;
  MyAppBarWidget({this.myLeftPadding});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: myLeftPadding, top: 60),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset('assets/images/Back Step.png')),
    );
  }
}
