import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/services/location_service.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/my_button_widget.dart';

class MySearchWidget extends StatefulWidget {
  final Function(String searchText) onSearch;
  final Widget iconWidget;
  final String hintText;
  final double myWidth;
  final Color? color;
  final bool? enable;
  final Function(bool enable)? onTap;
  const MySearchWidget(
      {required this.onSearch,
      this.color,
      this.onTap,
      required this.iconWidget,
      required this.hintText,
      this.enable = false,
      this.myWidth = 303,
      Key? key})
      : super(key: key);

  @override
  State<MySearchWidget> createState() => _MySearchWidgetState();
}

class _MySearchWidgetState extends State<MySearchWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: widget.myWidth.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextFormField(
        onTap: () => widget.onTap!(true),
        controller: searchController,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: SvgPicture.asset(
              'icons/search_icon.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          suffixIcon: MyWidgetButton(
            onTap: () async {
              widget.enable != true;
              widget.onSearch(searchController.text);
            },
            height: 20.h,
            width: 20.w,
            color: widget.color!,
            widget: Center(
              child: widget.iconWidget,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xffC5C5C5),
          ),
        ),
      ),
    );
  }
}
