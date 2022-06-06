import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/five_star_widget.dart';

class LivreurWidget extends StatelessWidget {
  final String livreurName;
  final String livreurAdresse;
  final String time;
  final String locationName;
  final String livreurPhotoPath;
  final int livreurRate;
  final VoidCallback taped;
  final bool isTaped;

  const LivreurWidget(
      {required this.livreurAdresse,
      required this.livreurName,
      required this.livreurPhotoPath,
      required this.livreurRate,
      required this.locationName,
      required this.time,
      required this.taped,
      required this.isTaped,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => taped(),
      child: SizedBox(
        width: 303.w,
        /*  decoration: BoxDecoration(
          border: Border.all(
            color: isTaped ? my_black : const Color(0xffF0F0F0),
            width: isTaped ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ), */
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 13.h,
                left: 10.w,
              ),
              // child: Container(
              //   height: 32.w,
              //   width: 32.w,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //     // color: Colors.black,
              //   ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  livreurPhotoPath,
                ),
              ),
            ),
            SizedBox(
              width: 12.2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  livreurName,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 6.1.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset('icons/location.svg'),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      livreurAdresse,
                      style: TextStyle(fontSize: 10.sp),
                      //maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 2.5.h,
                        ),
                        Container(
                          height: 3.7.h,
                          width: 1.w,
                          decoration: const BoxDecoration(
                            color: Color(0xffD8D4D4),
                          ),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        Container(
                          height: 3.7.h,
                          width: 1.w,
                          decoration: const BoxDecoration(
                            color: Color(0xffD8D4D4),
                          ),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        Container(
                          height: 3.7.h,
                          width: 1.w,
                          decoration: const BoxDecoration(
                            color: Color(0xffD8D4D4),
                          ),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        Container(
                          height: 3.7.h,
                          width: 1.w,
                          decoration: const BoxDecoration(
                            color: Color(0xffD8D4D4),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 7.9.w,
                        ),
                        SvgPicture.asset(
                          'icons/little_clock.svg',
                          height: 10.5.h,
                          width: 10.5.h,
                        ),
                        SizedBox(
                          width: 2.5.w,
                        ),
                        Text(
                          time,
                          style: TextStyle(fontSize: 9.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.2.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      'icons/Oval.png',
                      height: 8.h,
                      width: 8.h,
                    ),
                    SizedBox(
                      width: 2.9.w,
                    ),
                    Text(
                      locationName,
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    )
                  ],
                )
              ],
            ),

            ///////Rating livrreur
            // Padding(
            //   padding: EdgeInsets.only(top: 13.h),
            //   child: FiveStarWidget(
            //     livreurRate: livreurRate,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
