import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/livraison_quand_repo.dart';
import 'package:food_line/screens/location_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class LocalisationEnregistrerWidget extends StatefulWidget {
  final VoidCallback taped;
  final bool isTaped;
  String address;
  String ville;
  String? horaire;
  String? id;
  bool? ispanier;
  LocalisationEnregistrerWidget({
    required this.taped,
    required this.address,
    required this.horaire,
    required this.ville,
    required this.isTaped,
    this.id,
    this.ispanier = false,
    Key? key,
  }) : super(key: key);

  @override
  State<LocalisationEnregistrerWidget> createState() =>
      _LocalisationEnregistrerWidgetState();
}

class _LocalisationEnregistrerWidgetState
    extends State<LocalisationEnregistrerWidget> {
  @override
  void initState() {
    print("VILLE 1111 ADRESSSE");

    // TODO: implement initState
    super.initState();
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
                  child: SvgPicture.asset(
                    'icons/location.svg',
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
                      widget.ville,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
                      width: 190.w,
                      child: Text(
                        widget.address + "," + widget.ville + "," + "France",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xffA2A2A2),
                        ),
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
        widget.ispanier!
            ? Expanded(
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                alignment: Alignment.center,
                                //padding: EdgeInsets.only(bottom: 230),
                                color: Color(0xFFAEA9A3).withOpacity(0.2),
                                child: AlertDialog(
                                  scrollable: true,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
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
                                                "Etes-vous sûr de vouloir supprimer cette adresse?",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: my_green,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 50),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
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
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    onPressed: () {
                                                      print(widget.id);
                                                      TempsLivNotifier
                                                          .deleteAdress(
                                                              false,
                                                              widget.id,
                                                              context);
                                                      //  press();
                                                      // print(
                                                      //     widget.idpanier);
                                                      // viewModel
                                                      //     .supprimerPanier(
                                                      //         widget
                                                      //             .idpanier,
                                                      //         context);
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
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    onPressed: () {
                                                      // press();
                                                      Navigator.pop(context);

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
            : Expanded(
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
                      Navigator.push(
                        context,
                        PageTransition(
                          child: LocationScreen(
                            horaire: widget.horaire,
                            fromMenu: true,
                          ),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    }),
              )
      ],
    );
  }
}
