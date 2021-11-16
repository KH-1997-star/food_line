import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String time;
  final Color myColor;
  TimeButton({this.time, this.myColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 320,
        height: 50,
        color: myColor,
        child: TextButton(
            onPressed: () => Navigator.pushNamed(
                  context,
                  '/resto_screen',
                  arguments: {
                    'livrerTemp': time,
                  },
                ),
            child: Text(
              time,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            )));
  }
}
