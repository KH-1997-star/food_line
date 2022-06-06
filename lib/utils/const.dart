import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const hostDynamique = 'https://api.yesenergie.fr/';
const tokenconst = "token";
const idConst = 'id';
const idAnonym = 'idAnonym';
const nonCo = "nonCo";
const idPanier = "idPanier";
const idCmd = "idCmd";
const remember = "remember";
Center myBackIcon = Center(
  child: SvgPicture.asset(
    'icons/back_icon.svg',
    height: 16.h,
    width: 16.w,
  ),
);
const erreurUlterieur =
    'une erreur s\'est produite veuillez réessayer ultérieurement';
const erreurCnx =
    'une érreur c\'est produite veuillez vérifier votre connexion internet et réessayer';
