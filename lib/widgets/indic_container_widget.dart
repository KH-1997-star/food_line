import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/menuPage/menu_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);

class IndicContainerWidget extends ConsumerStatefulWidget {
  final bool fromMenu;
  final String? texte;
  final bool? panier;
  final int? index;
  final String? adresse;
  final String? horaire;
  final bool? ispanier;
  final String? dayLiv;
  const IndicContainerWidget(
      {this.fromMenu = false,
      this.adresse = "",
      this.panier = false,
      this.dayLiv = "",
      this.horaire = "",
      this.texte = "",
      this.index,
      this.ispanier = false,
      Key? key})
      : super(key: key);

  @override
  _IndicContainerWidgetState createState() => _IndicContainerWidgetState();
}

class _IndicContainerWidgetState extends ConsumerState<IndicContainerWidget> {
  getStations(String adress) async {
    print("hello");
    final viewModel = ref.read(panierProvider);
    print(adress);
    print(widget.horaire);
    bool? isToday;
    if (widget.dayLiv == "Now") {
      isToday = true;
    } else {
      isToday = false;
    }
    await viewModel
        .getListStation(context, adress, widget.horaire, null, isToday)
        .then((value) {
      print("KIKOIIIIIIIII");
      print(viewModel.listStations?.listeStations?.length);
      viewModel.listStations?.listeStations?.length == 0
          ? Toast.show("Pas de station à cette position", context,
              backgroundColor: Colors.red, duration: 3, gravity: 3)
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationCommand(
                  indexAdress: widget.index,
                  horaire: widget.horaire!,
                ),
              ),
            );
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: getWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(15.r, 25.r),
          topRight: Radius.elliptical(15.r, 25.r),
        ),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 36.w,
            ),
            MyWidgetButton(
                widget: myBackIcon,
                onTap: () async {
                  if (widget.fromMenu) {
                    widget.ispanier!
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationCommand(),
                            ),
                          )
                        : Navigator.push(
                            context,
                            PageTransition(
                              child: MenuScreen(),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                            ),
                          );
                  } else {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString(nonCo, "false");
                    Navigator.pushNamed(context, '/login');
                  }

                  // widget.panier!
                  //     ? getStations(widget.adresse!)
                  //     :
                }),
            SizedBox(
              width: 25.w,
            ),
            Text(
              widget
                  .texte!, //fromMenu ? 'Adresses enregistrées' : 'Indiquez votre position',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.sp,
                color: my_green,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
