import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/ListeMenu/liste_menu_repo.dart';
import 'package:food_line/utils/colors.dart';

final menuProvider = ChangeNotifierProvider<MenuNotifier>(
  (ref) => MenuNotifier(),
);

class MyFavoritButton extends ConsumerStatefulWidget {
  final double height;
  final double width;
  final Widget widget;
  final double radius;
  final Color color;
  final double borderWidth;
  final bool isBordred;
  final Color borderColor;
  final bool selected;
  final String? id;

  const MyFavoritButton({
    this.id,
    this.height = 40,
    this.width = 40,
    this.radius = 13,
    this.selected = false,
    this.borderColor = my_green,
    this.isBordred = false,
    this.borderWidth = 1,
    required this.widget,
    this.color = my_green,
    key,
  }) : super(key: key);

  @override
  _MyFavoritButtonState createState() => _MyFavoritButtonState();
}

class _MyFavoritButtonState extends ConsumerState<MyFavoritButton> {
  bool? selected;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      selected = widget.selected;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.read(menuProvider);
    return InkWell(
      onTap: () {
        setState(() {
          if (selected!) {
            selected = false;
            viewModel.lickerResto(widget.id!, context);
            print("hello1");
          } else {
            selected = true;
            print("hello2");
            viewModel.lickerResto(widget.id!, context);
          }
        });
      },
      child: Container(
        height: widget.height.h,
        width: widget.width.w,
        child: SvgPicture.asset(
          selected! ? 'icons/heart_red.svg' : 'icons/heart_green.svg',
          //color: selected ? Colors.red : my_green,
          height: 3.h,
          width: 3.w,
          fit: BoxFit.none,
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.radius.r),
          border: widget.isBordred
              ? Border.all(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                )
              : null,
        ),
      ),
    );
  }
}
