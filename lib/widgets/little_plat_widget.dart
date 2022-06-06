import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/utils/colors.dart';

class LittlePlatWidget extends StatefulWidget {
  final String titrePlat;
  final String pathPlat;
  final bool? local;
  final bool selected;
  final bool? init;
  final Function(bool)? onChooseTag;
  final VoidCallback? taped;
  final bool? isTaped;
  LittlePlatWidget(
      {required this.titrePlat,
      required this.pathPlat,
      this.init,
      this.onChooseTag,
      this.local = false,
      this.selected = false,
      this.taped,
      this.isTaped,
      Key? key})
      : super(key: key);

  @override
  State<LittlePlatWidget> createState() => _LittlePlatWidgetState();
}

class _LittlePlatWidgetState extends State<LittlePlatWidget> {
  bool? selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          print(widget.isTaped);
          selected = !widget.isTaped!;
        });
        if (selected!) {
          widget.onChooseTag!(true);
        } else {
          widget.onChooseTag!(false);
        }
      },
      //  onTap: () => taped!(),
      child: Container(
        height: 55.42.w,
        width: 55.42.w,
        decoration: BoxDecoration(
          border: Border.all(
              color: !widget.local!
                  ? widget.isTaped!
                      ? Colors.red
                      : Colors.transparent
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Stack(
          children: [
            !widget.local!
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      widget.pathPlat,
                      color: !widget.isTaped!
                          ? Color(0xff000000).withOpacity(0.2)
                          : Colors.transparent,
                      colorBlendMode: BlendMode.darken,
                      height: 55.42.w,
                      width: 55.42.w,
                      fit: BoxFit.fill,
                    ))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(2.r),
                    child: Image.asset(
                      widget.pathPlat,
                      height: 55.42.w,
                      width: 55.42.w,
                    )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget.titrePlat,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
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
