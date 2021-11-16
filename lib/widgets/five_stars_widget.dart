import 'package:flutter/material.dart';

class FiveStarsWidget extends StatelessWidget {
  final int yellowStar;
  FiveStarsWidget({@required this.yellowStar});

  @override
  Widget build(BuildContext context) {
    var isYellow = new List.filled(5, false, growable: false);
    for (int i = 0; i < yellowStar; i += 1) {
      isYellow[i] = true;
    }
    print(isYellow);

    return Container(
      width: 90,
      child: Row(
        children: [
          isYellow[0]
              ? Image.asset('assets/images/yellowstar.png')
              : Image.asset('assets/images/Iconly-Light-Star.png'),
          isYellow[1]
              ? Image.asset('assets/images/yellowstar.png')
              : Image.asset('assets/images/Iconly-Light-Star.png'),
          isYellow[2]
              ? Image.asset('assets/images/yellowstar.png')
              : Image.asset('assets/images/Iconly-Light-Star.png'),
          isYellow[3]
              ? Image.asset('assets/images/yellowstar.png')
              : Image.asset('assets/images/Iconly-Light-Star.png'),
          isYellow[4]
              ? Image.asset('assets/images/yellowstar.png')
              : Image.asset('assets/images/Iconly-Light-Star.png'),
        ],
      ),
    );
  }
}
