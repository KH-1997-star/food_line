import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/DetailsPlat/detail_plat.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/Panier/panier_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);

class PanierDetailWidget extends ConsumerStatefulWidget {
  final int xFood;
  final String? supp;
  final String menuText;
  final String supplement;
  final String? id;
  final String? idpanier;
  final bool? isHistorique;
  final String? image;
  const PanierDetailWidget({
    this.supp,
    this.idpanier,
    this.image,
    this.isHistorique = false,
    required this.xFood,
    required this.menuText,
    required this.supplement,
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  _PanierDetailWidgetState createState() => _PanierDetailWidgetState();
}

class _PanierDetailWidgetState extends ConsumerState<PanierDetailWidget> {
  @override
  Widget build(BuildContext context) {
    var viewModel = ref.read(panierProvider);
    return Row(
      children: [
        Expanded(
          flex: widget.isHistorique! ? 6 : 5,
          child: MyWidgetButton(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Image.network(
                          widget.image ?? "",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //   radius: 20.0,
                    //   backgroundColor: Colors.transparent,
                    //   backgroundImage: NetworkImage(
                    //     widget.image ?? "",
                    //   ),
                    // ),
                    //Container(child: Image.network(widget.image!)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'X ${widget.xFood}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: widget.isHistorique! ? 200.w : 180.w,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          widget.menuText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: SizedBox(
                        width: 210.w,
                        child: Text(
                          widget.supplement,
                          style: TextStyle(
                            fontSize: 12.sp,
                            //color: const Color(0xffA2A2A2),
                            //fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            onTap: () {
              print("helloooo");
              print(widget.idpanier);
              widget.isHistorique!
                  ? null
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPlatScreen(
                              id: widget.id,
                              ispanier: true,
                              idpanier: widget.idpanier)));
            },
            width: !widget.isHistorique! ? 110.w : 260.w,
            height: 80.h,
            color: Colors.white,
            isBordred: true,
            borderColor: const Color(0xffF0F0F0),
            borderWidth: 1.5,
          ),
        ),
        SizedBox(
          width: !widget.isHistorique! ? 0 : 9.w,
        ),
        widget.isHistorique!
            ? SizedBox()
            : Expanded(
                flex: 0,
                child: MyWidgetButton(
                  radius: 8,
                  color: const Color(0xffF0F0F0),
                  width: 20.w,
                  height: 20.h,
                  widget: Center(
                    child: SvgPicture.asset(
                      'icons/deleteIcon.svg',
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    widget.isHistorique!
                        ? null
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    //padding: EdgeInsets.only(bottom: 230),
                                    color: Color(0xFFAEA9A3).withOpacity(0.2),
                                    child: AlertDialog(
                                      scrollable: true,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      content: Container(
                                          constraints:
                                              BoxConstraints(minHeight: 150.0),
                                          //height: 200.h,
                                          width: 150.w,
                                          //padding: ,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 20,
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                    "Etes-vous sûr de vouloir supprimer ce menu?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: my_green,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 50),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      height: 30.h,
                                                      width: 80.w,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        color: my_green,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        onPressed: () {
                                                          //  press();
                                                          print(
                                                              widget.idpanier);
                                                          viewModel
                                                              .supprimerPanier(
                                                                  widget
                                                                      .idpanier,
                                                                  context);
                                                          //FadeTransition(opacity: , child: child);
                                                        },
                                                        child: Text("Oui",
                                                            style: TextStyle(
                                                                color: my_white,
                                                                fontSize: 12.sp,
                                                                fontFamily:
                                                                    "Roboto")),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30.h,
                                                      width: 80.w,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        color: my_black,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        onPressed: () {
                                                          // press();
                                                          Navigator.pop(
                                                              context);

                                                          //FadeTransition(opacity: , child: child);
                                                        },
                                                        child: Text("Non",
                                                            style: TextStyle(
                                                                color: my_white,
                                                                fontSize: 12.sp,
                                                                fontFamily:
                                                                    "Roboto")),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ));
                            });
                  },
                ),
              )
      ],
    );
  }
}
