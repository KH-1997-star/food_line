import 'package:flutter/cupertino.dart';

class CostumPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  final int myDuration;
  final int curveType;
  List curveList = [
    Curves.decelerate,
  ];

  CostumPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
    this.myDuration = 0,
    this.curveType = 0,
  }) : super(
          transitionDuration: Duration(milliseconds: myDuration),
          reverseTransitionDuration: Duration(milliseconds: myDuration),
          pageBuilder: (context, animation, secondryAnimation) => child,
        );
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).chain(CurveTween(curve: curveList[curveType])).animate(animation),
        child: child,
      );

  Offset getBeginOffset() {
    Offset myOffset;
    switch (direction) {
      case AxisDirection.up:
        myOffset = const Offset(0, 1);
        return myOffset;
      case AxisDirection.down:
        myOffset = const Offset(0, -1);
        return myOffset;
      case AxisDirection.left:
        myOffset = const Offset(1, 0);
        return myOffset;
      case AxisDirection.right:
        myOffset = const Offset(-1, 0);
        return myOffset;
    }
  }
}
