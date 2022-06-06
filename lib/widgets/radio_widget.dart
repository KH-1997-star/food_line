import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/services/provide_menu.dart';

import 'package:provider/provider.dart';

class MyFiltreChip extends StatefulWidget with ChangeNotifier {
  final String? tagName;
  final Function(String, bool)? onTag;
  final bool isSearch;
  final bool isSelected;
  final bool changeColor;
  List<String> tagsGiftToApi = [];
  List get tagsList => tagsGiftToApi;

  MyFiltreChip({
    this.tagName,
    this.onTag,
    this.isSearch = true,
    this.changeColor = false,
    this.isSelected = false,
  });

  @override
  _MyFiltreChipState createState() => _MyFiltreChipState();
}

class _MyFiltreChipState extends State<MyFiltreChip> {
  bool? isSelected;
  @override
  void initState() {
    super.initState();

    //getListProduct();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.tagName!,
        style: TextStyle(
          color: isSelected! ? Colors.white : Color(0xff8D89A5),
          fontSize: 16.sp,
          fontFamily: 'SemiBold',
        ),
      ),
      elevation: 0,
      selected: isSelected!,
      showCheckmark: false,
      backgroundColor: widget.changeColor ? Colors.grey[100] : Colors.black87,
      selectedColor: Color(0xffAF5F96),
      onSelected: (v) {
        setState(() {
          isSelected = v;
        });
        if (widget.isSearch) {
          widget.tagsGiftToApi.add(widget.tagName!);

          if (v) {
            context.read<MyCounter>().addTags(widget.tagName!);
          } else {
            context.read<MyCounter>().removeTags(widget.tagName!);
          }
        }
      },
    );
  }
}
