import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentWidget extends StatelessWidget {
  final String cartePath;
  final VoidCallback? taped;
  final bool? isTaped;
  const PaymentWidget({
    required this.cartePath,
    this.isTaped,
    this.taped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: MyWidgetButton(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: SvgPicture.asset(
                    cartePath,
                    height: 40.6.h,
                    width: 98.71.w,
                  ),
                ),
                SizedBox(
                  width: 24.6.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '****',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xffA2A2A2),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '****',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xffA2A2A2),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '****',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xffA2A2A2),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '1789',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xffA2A2A2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            '02/22',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xffA2A2A2),
                            ),
                          ),
                          SizedBox(
                            width: 30.h,
                          ),
                          Text(
                            '        ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xffA2A2A2),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              taped!();
            },
            width: 260.w,
            height: 61.h,
            color: Colors.white,
            isBordred: true,
            borderColor: isTaped! ? my_black : Color(0xffF0F0F0),
            borderWidth: isTaped! ? 2 : 1.5,
          ),
        ),
        SizedBox(
          width: 9.w,
        ),
        // Expanded(
        //   flex: 0,
        //   child: MyWidgetButton(
        //     radius: 8,
        //     color: const Color(0xffF0F0F0),
        //     width: 34.w,
        //     height: 61.h,
        //     widget: Center(
        //       child: SvgPicture.asset(
        //         'icons/edit.svg',
        //         height: 25,
        //       ),
        //     ),
        //     onTap: () {},
        //   ),
        // ),
      ],
    );
  }
}
