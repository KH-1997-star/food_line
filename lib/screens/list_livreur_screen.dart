import 'package:flutter/material.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/livreur_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';

class ListLivreurScreen extends StatefulWidget {
  const ListLivreurScreen({Key? key}) : super(key: key);

  @override
  State<ListLivreurScreen> createState() => _ListLivreurScreenState();
}

class _ListLivreurScreenState extends State<ListLivreurScreen> {
  int itemLength = 3;
  List<bool> myList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < itemLength; i += 1) {
      myList.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.w, vertical: 36.h),
                  child: Row(
                    children: [
                      MyWidgetButton(
                        widget: myBackIcon,
                        onTap: () => Navigator.pop(context),
                      ),
                      SizedBox(
                        width: 67.w,
                      ),
                      Text(
                        'Liste des livreurs',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: my_green,
                        ),
                      )
                    ],
                  ),
                ),
                
                Scrollbar(
                  child: SizedBox(
                    height: 380.h,
                    width: getWidth(context),
                    child: ListView.builder(
                      itemCount: itemLength,
                      itemBuilder: (context, index) => Column(
                        children: [
                          LivreurWidget(
                            isTaped: myList[index],
                            taped: () => setState(() {
                              myList = unClick(index, itemLength);
                            }),
                            livreurAdresse: 'Adresse',
                            livreurName: 'Livreur 1',
                            livreurRate: 5,
                            livreurPhotoPath: 'images/livreur_photo.png',
                            locationName: 'Ma localisation',
                            time: '10min-15min',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                      shrinkWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 36.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: myList.contains(true) ? 1 : 0.3,
                  child: InkWell(
                    onTap: () {
                      if (myList.contains(true)) Navigator.pop(context);
                    },
                    child: const MyTitleButton(
                      title: 'Confirmer',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
