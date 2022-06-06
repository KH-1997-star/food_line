import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';

class ButtonMap extends StatefulWidget {
  final Function? onTap;
  const ButtonMap({Key? key, this.onTap}) : super(key: key);

  @override
  State<ButtonMap> createState() => _ButtonMapState();
}

class _ButtonMapState extends State<ButtonMap> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap!();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: my_black,
            ),
            borderRadius: BorderRadius.circular(10.0.r)),
        height: 50.h,
        width: 70.w,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_pin,
              size: 12.h,
            ),
            Text("Localiser",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)),
            Text("mes livraisons",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 9.sp, fontWeight: FontWeight.normal)),
          ],
        )
            //Icon(Icons.location_pin)

            ),
      ),
    );
  }
}
