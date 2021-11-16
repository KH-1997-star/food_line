import 'package:flutter/material.dart';
import 'package:food_line/utils/my_colors.dart';

class CircularIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            RotationTransition(
              turns: AlwaysStoppedAnimation(230 / 360),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                          stops: [
                            0.5,
                            0.5,
                          ],
                          startAngle: 0.0,
                          endAngle: 3.14 * 2,
                          center: Alignment.center,
                          colors: [yellowPrincipal, Colors.grey[300]])
                      .createShader(rect);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 51,
                width: 51,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '25/50',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
