import 'package:flutter/material.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/titre_food_line_widget.dart';

import 'home_screen.dart';

class AProposScreen extends StatelessWidget {
  final bool? ishome;
  const AProposScreen({Key? key, this.ishome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 36.h,
            ),
            Row(
              children: [
                SizedBox(width: 36.w),
                MyWidgetButton(
                    widget: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      ishome!
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ))
                          : Navigator.pop(context);
                    }),
                SizedBox(
                  width: 82.w,
                ),
                Text(
                  'A propos',
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 45.h,
            ),
            const TitreFoodLine(
              fSize: 45,
            ),
            SizedBox(
              height: 39.h,
            ),
            SizedBox(
              height: 500,
              child: Padding(
                padding: EdgeInsets.only(right: 36.w, left: 39.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ',
                        style: TextStyle(fontSize: 14.sp, height: 2),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
