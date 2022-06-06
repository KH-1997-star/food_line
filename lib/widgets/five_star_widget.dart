import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/livreur_widget.dart';

class FiveStarWidget extends StatelessWidget {
  final int livreurRate;
  const FiveStarWidget({required this.livreurRate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<bool> livreurRateList = [];
    for (int i = 0; i < 5; i += 1) {
      if (i < livreurRate) {
        livreurRateList.add(true);
      } else {
        livreurRateList.add(false);
      }
    }
    print(livreurRateList);
    return Row(
      children: [
        !livreurRateList[0]
            ? SvgPicture.asset('icons/star_grey.svg')
            : SvgPicture.asset('icons/star_yellow.svg'),
        SizedBox(
          width: 2.9.w,
        ),
        !livreurRateList[1]
            ? SvgPicture.asset('icons/star_grey.svg')
            : SvgPicture.asset('icons/star_yellow.svg'),
        SizedBox(
          width: 2.9.w,
        ),
        !livreurRateList[2]
            ? SvgPicture.asset('icons/star_grey.svg')
            : SvgPicture.asset('icons/star_yellow.svg'),
        SizedBox(
          width: 2.9.w,
        ),
        !livreurRateList[3]
            ? SvgPicture.asset('icons/star_grey.svg')
            : SvgPicture.asset('icons/star_yellow.svg'),
        SizedBox(
          width: 2.9.w,
        ),
        !livreurRateList[4]
            ? SvgPicture.asset('icons/star_grey.svg')
            : SvgPicture.asset('icons/star_yellow.svg'),
        SizedBox(
          width: 2.9.w,
        ),
      ],
    );
  }
}
