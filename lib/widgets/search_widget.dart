import 'package:flutter/material.dart';
 

class SearchWidget extends StatelessWidget {
  final String hintText;
  final IconButton prefixIcon;
  final IconButton sufixIcon;
  final Function onSearchTap;
  SearchWidget({
    this.hintText,
    this.onSearchTap,
    this.prefixIcon,
    this.sufixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 26,
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        color: Color(0xffF1F1F1),
        child: TextField(
          onTap: onSearchTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xffA5A5A5),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: sufixIcon,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffF1F1F1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
