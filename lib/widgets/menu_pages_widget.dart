import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/screens/GererProfil/gerer_profil_screen.dart';
import 'package:food_line/screens/LocationLivreur/location_screen.dart';
import 'package:food_line/screens/Mes%20commandes/mes_commandes_screen.dart';
import 'package:food_line/screens/a_propos_screen.dart';
import 'package:food_line/screens/favoris_screen.dart';
import 'package:food_line/screens/location_screen.dart';
import 'package:food_line/screens/login/login_screen.dart';
import 'package:food_line/screens/login/signin_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPages extends StatefulWidget {
  final Function(Widget, String)? onTap;
  MenuPages({this.onTap});

  @override
  _MenuPagesState createState() => _MenuPagesState();
}

class _MenuPagesState extends State<MenuPages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/mesCommandes');
            //widget.onTap(MesCommandeScreen(), 'morpho');
          },
          child: Row(
            children: [
              SizedBox(width: 9.w),
              Container(
                width: 15.w,
                height: 13.h,
                child: SvgPicture.asset(
                  "icons/cmd.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 130.w,
                child: Text(
                  "Mes commandes",
                  style: TextStyle(
                    color: my_black,
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              SvgPicture.asset(
                "icons/forward.svg",
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 35.h,
        // ),
        // InkWell(
        //   child: Row(
        //     children: [
        //       SizedBox(width: 9.w),
        //       Container(
        //         width: 15.w,
        //         height: 13.h,
        //         child: SvgPicture.asset(
        //           "icons/payment.svg",
        //           fit: BoxFit.fill,
        //         ),
        //       ),
        //       SizedBox(width: 10.w),
        //       SizedBox(
        //         width: 130.w,
        //         child: Text(
        //           "Moyens de paiement",
        //           style: TextStyle(
        //             color: my_black,
        //             fontFamily: 'Roboto',
        //             fontSize: 12.sp,
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 120.w,
        //       ),
        //       SvgPicture.asset(
        //         "icons/forward.svg",
        //         fit: BoxFit.fill,
        //       ),
        //     ],
        //   ),
        //   // onTap: () => widget.onTap(EditAvatarScreen(), 'editAvatar'),
        // ),
        SizedBox(
          height: 35.h,
        ),
        InkWell(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const FavorisScreen(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 300),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 9.w),
              Container(
                width: 15.w,
                height: 13.h,
                child: SvgPicture.asset(
                  "icons/favoris.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 130.w,
                child: Text(
                  "Favoris",
                  style: TextStyle(
                    color: my_black,
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              SvgPicture.asset(
                "icons/forward.svg",
                fit: BoxFit.fill,
              ),
            ],
          ),
          //onTap: () => widget.onTap(UpdateInfoPersoScreen(), 'updateInfo'),
        ),
        SizedBox(
          height: 35.h,
        ),
        InkWell(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const LocationMenuScreen(
                fromMenu: true,
              ),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 300),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 9.w),
              Container(
                width: 15.w,
                height: 15.h,
                child: SvgPicture.asset(
                  "icons/adress.svg",
                  // fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 130.w,
                child: Text(
                  "Adresses enregitrées",
                  style: TextStyle(
                    color: my_black,
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              SvgPicture.asset(
                "icons/forward.svg",
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        InkWell(
          //ProfilScreen
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const ProfilScreen(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 300),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 9.w),
              Container(
                width: 15.w,
                height: 13.h,
                child: SvgPicture.asset(
                  "icons/info.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 130.w,
                child: Text(
                  "Gérer vos informations",
                  style: TextStyle(
                    color: my_black,
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              SvgPicture.asset(
                "icons/forward.svg",
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        InkWell(
          child: Row(
            children: [
              SizedBox(width: 9.w),
              SizedBox(
                width: 15.w,
                height: 13.h,
                child: SvgPicture.asset(
                  "icons/config.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 130.w,
                child: Text(
                  'Réglages',
                  style: TextStyle(
                    color: my_black,
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              SvgPicture.asset(
                "icons/forward.svg",
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        InkWell(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: const AProposScreen(),
              type: PageTransitionType.fade,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 25.w,
              ),
              SizedBox(
                width: 130.w,
                child: Text(
                  "A propos",
                  style: TextStyle(
                    color: my_black,
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 127.w,
              ),
              SvgPicture.asset(
                "icons/forward.svg",
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        InkWell(
            child: Row(
              children: [
                SizedBox(width: 12.w),
                SvgPicture.asset(
                  "icons/deconnexion.svg",
                  fit: BoxFit.fill,
                  width: 18.w,
                  height: 13.h,
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  width: 130.w,
                  child: Text(
                    "Se déconnecter",
                    style: TextStyle(
                      color: my_black,
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () async {
              print("3");
              ConnexionViewModel.signOut(context);

              //   StorageUtil.removeSharedData("token");
              //   StorageUtil.removeSharedData("id");
              //   StorageUtil.removeSharedData("remember");
              //   widget.onTap(ConnexionPage(), 'editAvatar');
            }),
      ],
    );
  }
}
