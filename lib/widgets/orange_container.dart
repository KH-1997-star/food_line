import 'package:flutter/material.dart';

class OrangeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 8,
      decoration: BoxDecoration(
          color: Color(0xffFFC529),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
