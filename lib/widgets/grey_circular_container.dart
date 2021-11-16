import 'package:flutter/material.dart';

class GreyCircularContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 8,
      decoration: BoxDecoration(
        color: Color(0xffDBDBDB),
        shape: BoxShape.circle,
      ),
    );
  }
}
