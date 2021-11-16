import 'package:flutter/material.dart';
 

class MySecondAnimatedMenuWidget extends StatelessWidget {
 final int index;
  final Function(int) onPageChanged;
  MySecondAnimatedMenuWidget({this.index, this.onPageChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: double.infinity,
      color: Color(0xffE9E9E9),
    );
  }
}
