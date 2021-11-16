import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 

class MyListTileWidget extends StatelessWidget {
  final String title;
  final String svgIconPath;
  final Function myFunction;
  MyListTileWidget({this.title, this.myFunction, this.svgIconPath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: myFunction,
      leading: SvgPicture.asset(svgIconPath),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
