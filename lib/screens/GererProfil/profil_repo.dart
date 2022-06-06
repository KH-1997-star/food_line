import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProfilUpdateNotifier extends ChangeNotifier {
  String urlUpdatePwd = "${hostDynamique}account/changerPassword";
  String urlUpdateProfil = "${hostDynamique}api/client/update/";
  changePassword(String? pwd, String? email, BuildContext context) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));

    var data = {"email": email, "password": pwd};
    print(data);
    var response = await http.post(Uri.parse(urlUpdatePwd),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        encoding: Encoding.getByName('utf-8'),
        body: data);
    print(response.body);
    try {
      if (response.statusCode == 200) {
        Loader.hide();
        Toast.show("Mot de passe changé avec succés", context,
            backgroundColor: Colors.green, duration: 2, gravity: 10);
        print("OKKKKK");
        Navigator.pop(context);
      } else {
        print(response.body);
        Loader.hide();
      }
    } on SocketException {
      Loader.hide();

      Toast.show("Veuillez vérifier votre connexion réseau.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();

      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  upadatePorfil(String? name, String? prenom, String? phone, String? email,
      BuildContext context) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    String? id = prefs.getString(idConst);
    var data = {
      "extraPayload": {
        'nom': name,
        'prenom': prenom,
        'phone': phone,
        'email': email,
      }
    };

    var response = await http.post(Uri.parse(urlUpdateProfil + id!),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200) {
      Loader.hide();
      print("Modification faite");
    } else if (response.statusCode == 401) {
      Loader.hide();
      Navigator.pushNamed(context, "/login");
    } else {
      print(response.body);
    }
  }
}
