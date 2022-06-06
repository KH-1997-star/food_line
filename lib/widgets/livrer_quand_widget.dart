import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/screens/GererProfil/gerer_profil_screen.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/livraison_quand_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'my_title_button_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

final tempsLivProvider = ChangeNotifierProvider<TempsLivNotifier>(
  (ref) => TempsLivNotifier(),
);

class LivrerQuandWidget extends ConsumerStatefulWidget {
  final bool? isUpdate;
  final bool? isTomorow;
  final bool? ispanier;

  const LivrerQuandWidget(
      {Key? key,
      this.isUpdate = false,
      this.ispanier = false,
      this.isTomorow = false})
      : super(key: key);

  @override
  _LivrerQuandWidgetState createState() => _LivrerQuandWidgetState();
}

class _LivrerQuandWidgetState extends ConsumerState<LivrerQuandWidget> {
  bool clicked = false;
  bool checkedValue = false;
  int heureMinMidi = 660;
  int heureMinSoir = 900;

  int heureMinNuit = 1020;

  String temp = '';
  List<bool> clickedList = [false, false, false];
  void whichClicked(List<bool> l, int x) {
    for (int i = 0; i < clickedList.length; i += 1) {
      if (x != i) {
        setState(() {
          clickedList[i] = false;
        });
      } else {
        setState(() {
          clickedList[i] = !clickedList[i];
        });
      }
    }
  }

  final currentTime = DateTime.now();
  int? nowInMinutes;
  testHoraire() {
    setState(() {
      print("@@@@@@@@@@@@@@@@@@@@@@@@");
      var Timenow = DateFormat.Hm().format(currentTime);
      nowInMinutes = currentTime.hour * 60 + currentTime.minute;

      print(
          "heuuuure NWO  ${currentTime.hour}    ${nowInMinutes}   ${heureMinMidi}   ${heureMinSoir}     ${heureMinNuit} ");
      print(heureMinMidi < nowInMinutes!);
      print(heureMinSoir < nowInMinutes!);
      print(heureMinNuit < nowInMinutes!);

      print("@@@@@@@@@@@@@@@@@@@@@@@@");
    });
  }

  String? jourLiv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testHoraire();
    widget.isUpdate! ? getHoraire() : null;
  }

  getHoraire() async {
    final viewModel = ref.read(profilProvider);
    await viewModel.getInfoClient(context).then((value) {
      setState(() {
        jourLiv = value?.joursLivraison;
      });
      print("helloooo hhhhh");
      print(value?.timeLivraison);
      if (value?.timeLivraison == "Now" && !widget.isTomorow!) {
        if (value?.tempsLivraison == "Midi") {
          whichClicked(clickedList, 0);
          clickedList[0] ? temp = 'Midi' : temp = '';
        } else if (value?.tempsLivraison == "Soir") {
          whichClicked(clickedList, 1);
          clickedList[1] ? temp = 'Soir' : temp = '';
        } else if (value?.tempsLivraison == "Nuit") {
          whichClicked(clickedList, 2);
          clickedList[2] ? temp = 'Nuit' : temp = '';
        }
      }
      if (value?.timeLivraison == "Tomorrow" && widget.isTomorow!) {
        if (value?.tempsLivraison == "Midi") {
          whichClicked(clickedList, 0);
          clickedList[0] ? temp = 'Midi' : temp = '';
        } else if (value?.tempsLivraison == "Soir") {
          whichClicked(clickedList, 1);
          clickedList[1] ? temp = 'Soir' : temp = '';
        } else if (value?.tempsLivraison == "Nuit") {
          whichClicked(clickedList, 2);
          clickedList[2] ? temp = 'Nuit' : temp = '';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(tempsLivProvider);

    return Container(
      height: 450.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                MyWidgetButton(
                  widget: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 90.w,
                ),
                Text(
                  'Alerte info',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: my_green,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 21.h,
            ),
            Text(
              widget.isUpdate!
                  ? 'Veuillez choisir votre horaire de livraison souhaité'
                  : 'Souhaitez-vous être livrer ?',
              style: TextStyle(
                fontSize: widget.isUpdate! ? 13.sp : 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            MyWidgetButton(
                borderColor: heureMinMidi < nowInMinutes! && !widget.isTomorow!
                    ? Colors.red
                    : my_green,
                isBordred: true,
                width: 303,
                height: 38,
                borderWidth: 2,
                color: heureMinMidi < nowInMinutes! && !widget.isTomorow!
                    ? myLightRed
                    : clickedList[0]
                        ? myLightGreen
                        : my_white,
                widget: Stack(
                  children: [
                    Positioned(
                      top: 10.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 17.w,
                          ),
                          Text(
                            widget.isTomorow!
                                ? "Midi (Demain)"
                                : 'Midi (Avant 11h)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: heureMinMidi < nowInMinutes! &&
                                    !widget.isTomorow!
                                ? 100.w
                                : widget.isTomorow!
                                    ? 150.w
                                    : 140.w,
                          ),
                          heureMinMidi < nowInMinutes! && !widget.isTomorow!
                              ? Text(
                                  "(Dépassé)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: clickedList[0] ? 16.h : 0,
                                  width: clickedList[0] ? 16.w : 0,
                                  child: SvgPicture.asset('icons/checked.svg'),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  print(heureMinMidi);
                  print(nowInMinutes);
                  print(heureMinMidi > nowInMinutes!);
                  if (heureMinMidi > nowInMinutes! || widget.isTomorow!) {
                    whichClicked(clickedList, 0);
                    clickedList[0] ? temp = 'Midi' : temp = '';
                  }
                }),
            SizedBox(
              height: 11.h,
            ),
            MyWidgetButton(
                borderColor: heureMinSoir < nowInMinutes! && !widget.isTomorow!
                    ? Colors.red
                    : my_green,
                isBordred: true,
                width: 303,
                height: 38,
                borderWidth: 2,
                color: heureMinSoir < nowInMinutes! && !widget.isTomorow!
                    ? myLightRed
                    : clickedList[1]
                        ? myLightGreen
                        : my_white,
                widget: Stack(
                  children: [
                    Positioned(
                      top: 10.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 17.w,
                          ),
                          Text(
                            widget.isTomorow!
                                ? "Soir (Demain)"
                                : 'Soir (Avant 15h)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: heureMinSoir < nowInMinutes! &&
                                    !widget.isTomorow!
                                ? 100.w
                                : widget.isTomorow!
                                    ? 150.w
                                    : 140.w,
                          ),
                          heureMinSoir < nowInMinutes! && !widget.isTomorow!
                              ? Text(
                                  "(Dépassé)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: clickedList[1] ? 16.h : 0,
                                  width: clickedList[1] ? 16.w : 0,
                                  child: SvgPicture.asset('icons/checked.svg'),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (heureMinSoir > nowInMinutes! || widget.isTomorow!) {
                    whichClicked(clickedList, 1);
                    clickedList[1] ? temp = 'Soir' : temp = '';
                  }
                }),
            SizedBox(
              height: 11.h,
            ),
            MyWidgetButton(
                isBordred: true,
                borderColor: heureMinNuit < nowInMinutes! && !widget.isTomorow!
                    ? Colors.red
                    : my_green,
                width: 303,
                height: 38,
                borderWidth: 2,
                color: heureMinNuit < nowInMinutes! && !widget.isTomorow!
                    ? myLightRed
                    : clickedList[2]
                        ? myLightGreen
                        : my_white,
                widget: Stack(
                  children: [
                    Positioned(
                      top: 10.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 17.w,
                          ),
                          Text(
                            widget.isTomorow!
                                ? "Nuit (Demain)"
                                : 'Nuit (Avant 17h)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          //  SizedBox(width: widget.isTomorow! ? 0.w : 100.w),

                          SizedBox(
                            width: heureMinNuit < nowInMinutes! &&
                                    !widget.isTomorow!
                                ? 100.w
                                : widget.isTomorow!
                                    ? 150.w
                                    : 140.w,
                          ),
                          heureMinNuit < nowInMinutes! && !widget.isTomorow!
                              ? Text(
                                  "(Dépassé)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: clickedList[2] ? 16.h : 0,
                                  width: clickedList[2] ? 16.w : 0,
                                  child: SvgPicture.asset('icons/checked.svg'),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (heureMinNuit > nowInMinutes! || widget.isTomorow!) {
                    whichClicked(clickedList, 2);

                    clickedList[2] ? temp = 'Nuit' : temp = '';
                  }
                }),
            SizedBox(
              height: widget.isUpdate! ? 15.h : 15.h,
            ),
            // widget.isUpdate! || !widget.ispanier!
            //     ?
            !widget.isTomorow!
                ? MyWidgetButton(
                    color: my_white,
                    borderColor: my_green,
                    isBordred: true,
                    width: 303,
                    height: 38,
                    borderWidth: 2,
                    onTap: () => _showBottomSheet(context, widget.ispanier!),
                    widget: Stack(
                      children: [
                        Positioned(
                          top: 10.h,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 17.w,
                              ),
                              Text(
                                'Vous souhaitez être livré demain?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: widget.isTomorow! ? 150.w : 140.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                // child: Container(

                //     alignment: Alignment.centerRight,
                //     child: Text('Vous souhaitez être livré demain?',
                //         style: TextStyle(fontWeight: FontWeight.bold))),

                : SizedBox(),
            widget.isUpdate! ? SizedBox() : SizedBox(height: 10.h),
            widget.isUpdate!
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      setState(() {
                        checkedValue = !checkedValue;
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                            // width: 5.w,
                            ),
                        Container(
                          height: 20.h,
                          width: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: my_green, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.white),
                          child: checkedValue
                              ? Icon(
                                  Icons.check,
                                  size: 15.0,
                                  color: my_green,
                                )
                              : SizedBox(),
                        ),
                        SizedBox(width: 5.w),
                        Text("Ne plus m'afficher cette alerte")
                      ],
                    ),
                  ),
            SizedBox(
              height: widget.isUpdate! ? 20.h : 14.h,
            ),
            InkWell(
              onTap: () async {
                if (temp == '') {
                  Toast.show(
                    'il faut choisir un temp de livraison',
                    context,
                    backgroundColor: Colors.red,
                    gravity: 5,
                    duration: 3,
                  );
                } else {
                  print(temp);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  print(checkedValue.toString());
                  print("iiiiisssssUpdated");
                  print(widget.isUpdate);
                  print(widget.isTomorow);
                  // print()
                  widget.isUpdate!
                      ? null
                      : prefs.setString(remember, checkedValue.toString());
                  print('chhhhhhecked value');
                  print(checkedValue.toString());
                  print(checkedValue);
                  viewModel.setTempsLivraison(
                      temp, context, widget.isTomorow!, widget.ispanier!);

                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     child: const HomeScreen(),
                  //     type: PageTransitionType.fade,
                  //     curve: Curves.decelerate,
                  //     duration: const Duration(
                  //       milliseconds: 1000,
                  //     ),
                  //   ),
                  // );
                }
              },
              child: MyTitleButton(
                height: 45.h,
                title: 'Confirmer',
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<void> _showBottomSheet(
      BuildContext context, bool ispanier) async {
    int? result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: LivrerQuandWidget(
            isUpdate: true,
            isTomorow: true,
            ispanier: ispanier,
          ),
        ),
      ),
    );
  }
}
