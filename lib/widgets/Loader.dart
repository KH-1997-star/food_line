import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertCenterWidget extends StatelessWidget {
  const AlertCenterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.15,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
        ),
      ),
    );
  }
}
