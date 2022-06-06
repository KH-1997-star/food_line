import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';

import 'panier_details_widget.dart';
import 'somme_totale_widget.dart';

class VoirPanierWidget extends StatelessWidget {
  final VoidCallback onBackClick;
  final VoidCallback onCommandClick;
  const VoirPanierWidget({
    required this.onBackClick,
    required this.onCommandClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemLength = 1;
    return Container(
      constraints: BoxConstraints(minHeight: 372.h, maxHeight: 700.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 36.w, top: 27.h),
              child: Row(children: [
                MyWidgetButton(widget: myBackIcon, onTap: () => onBackClick()),
                SizedBox(
                  width: 66.w,
                ),
                Text(
                  'Burger King',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: my_green,
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 26.h,
            ),
            Scrollbar(
              child: SizedBox(
                height: itemLength < 4 ? 75.h * itemLength : 75.h * 4,
                width: getWidth(context),
                child: ListView.builder(
                  itemCount: itemLength,
                  itemBuilder: (context, index) => Column(
                    children: [
                      const PanierDetailWidget(
                        xFood: 1,
                        menuText: '2 Menus +9 Kings Nuggets',
                        supplement: 'Medium-Bacon Lover - Frites',
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                  ),
                  shrinkWrap: true,
                ),
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            const SommeTotaleWidget(
              sousTotal: 22.90,
              fraisLivraison: 0,
              fraisService: 0,
            ),
            SizedBox(
              height: 21.h,
            ),
            InkWell(
              onTap: () => onCommandClick(),
              child: const MyTitleButton(
                title: 'Commander',
              ),
            ),
            SizedBox(
              height: 36.h,
            )
          ],
        ),
      ),
    );
  }
}
