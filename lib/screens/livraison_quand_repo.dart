import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:food_line/models/liste_adress_model.dart';
import 'package:food_line/screens/LocationLivreur/location_screen.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/location_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'location_command_screen.dart';

class TempsLivNotifier extends ChangeNotifier {
  static String url = hostDynamique + "create/adresseLivraison";
  static String urlUpdate = hostDynamique + "update/";
  String urlListeAd =
      hostDynamique + "readAll/adresseLivraison?isActive=1&linkedCompte=";
  ListeAdress? listeadresse;
  setTempsLivraison(String? time, BuildContext context, bool dateLivraison,
      bool ispanier) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data = {
      "extraPayload": {
        "tempsLivraison": time,
        'timeLivraison': dateLivraison ? "Tomorrow" : "Now"
      }
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(nonCo));
    String? id = prefs.getString(nonCo) == 'false'
        ? prefs.getString(idConst)
        : prefs.getString(idAnonym);
    print(urlUpdate + id!);
    try {
      var response = await http.post(Uri.parse(urlUpdate + id),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        Loader.hide();
        ispanier
            ? Navigator.push(
                context,
                PageTransition(
                  child: LocationCommand(),
                  type: PageTransitionType.fade,
                  curve: Curves.decelerate,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                ),
              )
            : Navigator.push(
                context,
                PageTransition(
                  child: const HomeScreen(),
                  type: PageTransitionType.fade,
                  curve: Curves.decelerate,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                ),
              );
      } else {
        print(response.body);
        Loader.hide();
        print("Il semble qu'il a y eu un problème !.");
        Toast.show("Il semble qu'il a y eu un problème !", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
      }
    } on SocketException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);

      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
      /* showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader
          .hide(); /*  showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  static setAdresseProfil(
      String? adress, BuildContext context, bool ispanier) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data = {
      "extraPayload": {
        "addresse": adress,
        // 'timeLivraison': dateLivraison ? "Tomorrow" : "Now"
      }
    };
    print(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(nonCo) == 'false'
        ? prefs.getString(idConst)
        : prefs.getString(idAnonym);
    print(urlUpdate + id!);
    try {
      var response = await http.post(Uri.parse(urlUpdate + id),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Loader.hide();
        ispanier
            ? Navigator.push(
                context,
                PageTransition(
                  child: LocationCommand(),
                  type: PageTransitionType.fade,
                  curve: Curves.decelerate,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                ),
              )
            : Navigator.push(
                context,
                PageTransition(
                  child: const HomeScreen(
                    isFirstTime: true,
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.decelerate,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                ),
              );
      } else {
        print(response.body);
        Loader.hide();
        print("Il semble qu'il a y eu un problème !.");
        Toast.show("Il semble qu'il a y eu un problème !", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
      }
    } on SocketException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);

      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
      /* showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader
          .hide(); /*  showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  static Future<dynamic> setMyAdress(
    dynamic? lat,
    dynamic? lng,
    dynamic? ville,
    dynamic codePostal,
    dynamic? adress,
    bool? isFromMenu,
    BuildContext context,
    bool? isadd,
    String? isAddNon,
  ) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(nonCo) == 'false'
        ? prefs.getString(idConst)
        : prefs.getString(idAnonym);
    print(id);
    var data = {
      "extraPayload": {
        "ville": ville,
        "addresse": adress,
        "pays": "France",
        "codePostal": codePostal,
        "linkedCompte": id,
        "isActive": "1",
        "position": [lat!, lng!]
      }
    };
    print(data);

    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      print("Hellooooooooooooooooo Adressseeeeeee========>");
      var body = jsonDecode(response.body);
      print(body);
      print("Hellooooooooooooooooo Adressseeeeeee========>");

      if (response.statusCode == 200) {
        Loader.hide();
        isFromMenu!
            ? isadd!
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationMenuScreen(
                        fromMenu: true,
                      ),
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationScreen(
                        fromMenu: true,
                      ),
                    ),
                  )
            : setAdresseProfil(body, context, false);
        // : Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const HomeScreen(
        //         isFirstTime: true,
        //       ),
        //     ));
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
        return body;
      } else {
        print(response.body);
        Loader.hide();
        print("Il semble qu'il a y eu un problème !.");
        Toast.show("Il semble qu'il a y eu un problème !", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
        return false;
      }
    } on SocketException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);

      print("Il semble qu'il a y eu un problème !.");
      return false;
    } on HttpException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
      /* showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
      return false;
    } on FormatException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader
          .hide(); /*  showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
      return false;
    }
  }

  listeAdresseLivraison() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(idConst);
    String? idClient = prefs.getString(nonCo) == "true"
        ? prefs.getString(idAnonym)
        : prefs.getString(idConst);
    // isSearch = false;
    ListeAdress? listspec;
    print("*********************Adresse**********************");
    print(urlListeAd + idClient!);

    await http.get(Uri.parse(urlListeAd + idClient)).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        print(json.decode(response.body));
        print("********************Adresse2***********************");

        listspec = ListeAdress.fromJson(json.decode(response.body));

        listeadresse = listspec;
        print(listeadresse);
        notifyListeners();
      } else {
        print("ERROR");
      }
    }).catchError((error) {
      print("ERROR**************");
      listeadresse = null;
      // isSearch = true;
      notifyListeners();
    });
  }

  static setNumPhone(String? phone, BuildContext context) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data = {
      "extraPayload": {"phone": phone}
    };
    print(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(idConst);

    print(id);
    print(urlUpdate + id!);
    try {
      var response = await http.post(Uri.parse(urlUpdate + id),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Loader.hide();
        Navigator.pushNamed(context, '/slide_screen');
      } else {
        print(response.body);
        Loader.hide();
        print("Il semble qu'il a y eu un problème !.");
        Toast.show("Il semble qu'il a y eu un problème !", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
      }
    } on SocketException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);

      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
      /* showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader
          .hide(); /*  showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  static deleteAdress(bool? ismenu, String? id, BuildContext context) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data = {
      "extraPayload": {
        "isActive": "0",
        // 'timeLivraison': dateLivraison ? "Tomorrow" : "Now"
      }
    };
    print(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String? id = prefs.getString(nonCo) == 'false'
    //     ? prefs.getString(idConst)
    //     : prefs.getString(idAnonym);
    print(id);
    print(urlUpdate + id!);
    try {
      var response = await http.post(Uri.parse(urlUpdate + id),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      var body = jsonDecode(response.body);
      print("HELLOOOOOO Adresse Liv deleted ");
      print(body);
      if (response.statusCode == 200) {
        Loader.hide();
        ismenu!
            ? Navigator.push(
                context,
                PageTransition(
                  child: LocationMenuScreen(
                    fromMenu: true,
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.decelerate,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                ),
              )
            : Navigator.push(
                context,
                PageTransition(
                  child: LocationCommand(),
                  type: PageTransitionType.fade,
                  curve: Curves.decelerate,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                ),
              );
      } else {
        print(response.body);
        Loader.hide();
        print("Il semble qu'il a y eu un problème !.");
        Toast.show("Il semble qu'il a y eu un problème !", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
      }
    } on SocketException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);

      print("Il semble qu'il a y eu un problème !.");
    } on HttpException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
      /* showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader
          .hide(); /*  showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    }
  }
}
