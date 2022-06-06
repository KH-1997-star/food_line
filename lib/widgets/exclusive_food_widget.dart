import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ExclusiveFoodWidget extends StatelessWidget {
  final double myHeight;
  final double myWidth;
  final String myPath;
  final String? myUrl;
  const ExclusiveFoodWidget(
      {this.myHeight = 170,
      this.myWidth = 303,
      required this.myPath,
      this.myUrl,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20.r,
          ),
          color: Colors.black,
        ),
        height: myHeight.h,
        width: myWidth.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.network(
            myPath,
            fit: BoxFit.fill,
          ),
        ));
  }

  _launchURL() async {
    // const url = myUrl;
    if (await canLaunch(myUrl!)) {
      await launch(myUrl!);
    } else {
      throw 'Could not launch $myUrl';
    }
  }
}
