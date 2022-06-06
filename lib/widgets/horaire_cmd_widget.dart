import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/livrer_quand_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);

class HoraireCmdWidget extends ConsumerStatefulWidget {
  final VoidCallback taped;
  final bool isTaped;
  final String? address;
  String? horaire;
  String? dayLiv;
  Function(String v)? onChange;
  final TextEditingController? controller;
  HoraireCmdWidget({
    this.dayLiv,
    required this.taped,
    this.horaire,
    this.onChange,
    this.controller,
    this.address,
    required this.isTaped,
    Key? key,
  }) : super(key: key);

  @override
  _HoraireCmdWidgetState createState() => _HoraireCmdWidgetState();
}

class _HoraireCmdWidgetState extends ConsumerState<HoraireCmdWidget> {
  bool isenabled = false;
  bool clicked = false;
  // getStations(String tmp) async {
  //   print("hello");
  //    bool? isToday;
  //   if (widget.dayLiv == "Now") {
  //     isToday = true;
  //   } else {
  //     isToday = false;
  //   }
  //   final viewModel = ref.read(panierProvider);
  //   await viewModel.getListStation(widget.address, tmp, null).then((value) {
  //     viewModel.listStations?.listeStations?.length == 0
  //         ? Toast.show("Pas de station à cette heure", context,
  //             backgroundColor: Colors.red, duration: 5, gravity: 3)
  //         : Navigator.pop(context);
  //   });

  //   setState(() {});
  // }

  String temp = '';
  List<bool> clickedList = [false, false, false];
  void whichClicked(List<bool> l, int x, StateSetter setStat) {
    for (int i = 0; i < clickedList.length; i += 1) {
      if (x != i) {
        setStat(() {
          clickedList[i] = false;
        });
      } else {
        setStat(() {
          clickedList[i] = !clickedList[i];
        });
      }
    }
  }

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
                  padding: EdgeInsets.only(left: 16.6.w),
                  child: Image.asset(
                    'icons/horaire.png',
                    height: 21.61.h,
                    width: 14.53.w,
                  ),
                ),
                SizedBox(
                  width: 26.9.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.horaire ?? "",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: my_black,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Horaire de livraison ',
                      style: TextStyle(
                        color: my_hint,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
            onTap: () {
              widget.taped();
            },
            width: 260.w,
            height: 61.h,
            color: Colors.white,
            isBordred: true,
            borderColor: widget.isTaped ? my_black : const Color(0xffF0F0F0),
            borderWidth: widget.isTaped ? 2 : 1.5,
          ),
        ),
        SizedBox(
          width: 9.w,
        ),
        Expanded(
          flex: 0,
          child: MyWidgetButton(
              radius: 8,
              color: const Color(0xffF0F0F0),
              width: 34.w,
              height: 61.h,
              widget: Center(
                child: SvgPicture.asset('icons/edit.svg'),
              ),
              onTap: () {
                _showBottomSheet(context);
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return StatefulBuilder(
                //           builder: (context, StateSetter setState) {
                //         return BackdropFilter(
                //             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                //             child: Container(
                //               alignment: Alignment.center,
                //               //padding: EdgeInsets.only(bottom: 230),
                //               color: Color(0xFFAEA9A3).withOpacity(0.2),
                //               child: AlertDialog(
                //                 scrollable: true,
                //                 backgroundColor: Colors.white,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10.0),
                //                 ),
                //                 content: Container(
                //                     constraints:
                //                         BoxConstraints(minHeight: 150.0),
                //                     //height: 200.h,
                //                     width: 150.w,
                //                     //padding: ,
                //                     child: Column(
                //                       children: [
                //                         Container(
                //                           alignment: Alignment.topRight,
                //                           child: IconButton(
                //                             onPressed: () {
                //                               Navigator.of(context).pop();
                //                             },
                //                             icon: Icon(
                //                               Icons.close,
                //                               size: 20,
                //                             ),
                //                           ),
                //                         ),
                //                         Text(
                //                           'Souhaitez-vous être livré ?',
                //                           textAlign: TextAlign.center,
                //                           style: TextStyle(
                //                             fontSize: 16.sp,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ),
                //                         SizedBox(
                //                           height: 24.h,
                //                         ),
                //                         MyWidgetButton(
                //                             isBordred: true,
                //                             width: 200,
                //                             height: 30,
                //                             borderWidth: 1,
                //                             color: clickedList[0]
                //                                 ? myLightGreen
                //                                 : my_white,
                //                             widget: Stack(
                //                               children: [
                //                                 Positioned(
                //                                   top: 5.h,
                //                                   left: 10.w,
                //                                   child: Row(
                //                                     children: [
                //                                       Text(
                //                                         'Midi',
                //                                         style: TextStyle(
                //                                           fontSize: 13.sp,
                //                                           fontWeight:
                //                                               FontWeight.w500,
                //                                         ),
                //                                       ),
                //                                       SizedBox(width: 130.w),
                //                                       AnimatedContainer(
                //                                         duration:
                //                                             const Duration(
                //                                                 milliseconds:
                //                                                     500),
                //                                         height: clickedList[0]
                //                                             ? 16.h
                //                                             : 0,
                //                                         width: clickedList[0]
                //                                             ? 16.w
                //                                             : 0,
                //                                         child: SvgPicture.asset(
                //                                             'icons/checked.svg'),
                //                                       )
                //                                     ],
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                             onTap: () {
                //                               whichClicked(
                //                                   clickedList, 0, setState);
                //                               clickedList[0]
                //                                   ? temp = 'Midi'
                //                                   : temp = '';
                //                             }),
                //                         SizedBox(
                //                           height: 11.h,
                //                         ),
                //                         MyWidgetButton(
                //                             isBordred: true,
                //                             width: 200,
                //                             height: 30,
                //                             borderWidth: 1,
                //                             color: clickedList[1]
                //                                 ? myLightGreen
                //                                 : my_white,
                //                             widget: Stack(
                //                               children: [
                //                                 Positioned(
                //                                   top: 5.h,
                //                                   left: 10.w,
                //                                   child: Row(
                //                                     children: [
                //                                       Text(
                //                                         'Soir',
                //                                         style: TextStyle(
                //                                           fontSize: 13.sp,
                //                                           fontWeight:
                //                                               FontWeight.w500,
                //                                         ),
                //                                       ),
                //                                       SizedBox(width: 130.w),
                //                                       AnimatedContainer(
                //                                         duration:
                //                                             const Duration(
                //                                                 milliseconds:
                //                                                     500),
                //                                         height: clickedList[1]
                //                                             ? 16.h
                //                                             : 0,
                //                                         width: clickedList[1]
                //                                             ? 16.w
                //                                             : 0,
                //                                         child: SvgPicture.asset(
                //                                             'icons/checked.svg'),
                //                                       )
                //                                     ],
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                             onTap: () {
                //                               whichClicked(
                //                                   clickedList, 1, setState);
                //                               clickedList[1]
                //                                   ? temp = 'Soir'
                //                                   : temp = '';
                //                             }),
                //                         SizedBox(
                //                           height: 11.h,
                //                         ),
                //                         MyWidgetButton(
                //                             isBordred: true,
                //                             width: 200,
                //                             height: 30,
                //                             borderWidth: 1,
                //                             color: clickedList[2]
                //                                 ? myLightGreen
                //                                 : my_white,
                //                             widget: Stack(
                //                               children: [
                //                                 Positioned(
                //                                   top: 5.h,
                //                                   left: 10.w,
                //                                   //top: 15.h,
                //                                   child: Row(
                //                                     children: [
                //                                       Text(
                //                                         'Nuit',
                //                                         style: TextStyle(
                //                                           fontSize: 13.sp,
                //                                           fontWeight:
                //                                               FontWeight.w500,
                //                                         ),
                //                                       ),
                //                                       SizedBox(width: 130.w),
                //                                       // SizedBox(
                //                                       //   width: 230.w,
                //                                       // ),
                //                                       AnimatedContainer(
                //                                         duration:
                //                                             const Duration(
                //                                                 milliseconds:
                //                                                     500),
                //                                         height: clickedList[2]
                //                                             ? 16.h
                //                                             : 0,
                //                                         width: clickedList[2]
                //                                             ? 16.w
                //                                             : 0,
                //                                         child: SvgPicture.asset(
                //                                             'icons/checked.svg'),
                //                                       )
                //                                     ],
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                             onTap: () {
                //                               whichClicked(
                //                                   clickedList, 2, setState);

                //                               clickedList[2]
                //                                   ? temp = 'Nuit'
                //                                   : temp = '';
                //                             }),
                //                         Container(
                //                           padding: EdgeInsets.only(top: 20),
                //                           child: Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceAround,
                //                             children: [
                //                               Container(
                //                                 height: 30.h,
                //                                 width: 200.w,
                //                                 child: RaisedButton(
                //                                   elevation: 0.0,
                //                                   color: my_green,
                //                                   shape: RoundedRectangleBorder(
                //                                     borderRadius:
                //                                         BorderRadius.circular(
                //                                             10.0),
                //                                   ),
                //                                   onPressed: () {
                //                                     widget.onChange!(temp);
                //                                     print(temp);
                //                                     setState(() {
                //                                       widget.horaire = temp;
                //                                       getStations(temp);
                //                                     });
                //                                   },
                //                                   child: Text("Confirmer",
                //                                       style: TextStyle(
                //                                           color: my_white,
                //                                           fontSize: 12.sp,
                //                                           fontFamily:
                //                                               "Roboto")),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //               ),
                //             ));
                //       });
                //  });
              }),
        )
      ],
    );
  }

  static Future<void> _showBottomSheet(BuildContext context) async {
    int? result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => const SafeArea(
          child: LivrerQuandWidget(
            ispanier: true,
            isUpdate: true,
          ),
        ),
      ),
    );
  }
}
