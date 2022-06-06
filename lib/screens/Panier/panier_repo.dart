import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/models/default_address_model.dart';
import 'package:food_line/models/liste_stations_model.dart';
import 'package:food_line/models/panier.dart';
import 'package:food_line/models/selected_detail_menu.dart';
import 'package:food_line/screens/ListeMenu/detail_category_screen.dart';
import 'package:food_line/screens/Panier/liste_station_screen.dart';
import 'package:food_line/screens/Panier/panier_screen.dart';
import 'package:food_line/screens/Panier/recap.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';

import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../payment_screen.dart';

class PanierNotifier extends ChangeNotifier {
  static const String urlGetPanier = '${hostDynamique}getMonPanier';
  static const String urlAjoutPaniert = '${hostDynamique}ajoutMenuAuPanier';
  static const String urlPanierSelected = '${hostDynamique}read/';
  static const String urlUpdatePanier = '${hostDynamique}updateMenuAuPanier';
  static const String urlSuppPanier = '${hostDynamique}removeProduitFromPanier';
  static const String urlCmd = '${hostDynamique}api/client/createCommande';
  static const String urlCmdUpdate =
      '${hostDynamique}api/client/affecterAddresseLivraisonToCommande';
  static const String urlCheck = "${hostDynamique}" + "checkStations";
  List<Panier>? listPanier;
  ListeStation? listStations;
  List<DetailMenuSelected>? listMenuSelected;
  List<DefaultAddress>? adresseSelected;

  var _prix;
  double get prix => _prix;
  static final provider = ChangeNotifierProvider<PanierNotifier>((ref) {
    return PanierNotifier();
  });
  getPanier(BuildContext context) async {
    try {
      List<Panier> listPanierProvider;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(tokenconst);
      String? id = prefs.getString(idConst);
      String? idAnonyme = prefs.getString("idAnonym");
      // print('MYIDDDDDD//: $id');
      // print(urlGetPanier);
      // print("Anonyyyymmmmeeee****************");
      // print(idAnonyme);
      // print("Anonyyyymmmmeeee****************");
      // print(prefs.getString(idConst));
      // print(prefs.getString(idAnonym));
      // print(prefs.getString(nonCo));
      final response = await http.post(
        Uri.parse(urlGetPanier),
        headers: <String, String>{
          'Content-Type': 'application/json',
          //  'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {
            'extraPayload': {
              'linkedCompte': prefs.getString(nonCo) == "true"
                  ? prefs.getString(idAnonym)
                  : prefs.getString(idConst),
              'statut': 'active',
            }
          },
        ),
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        // print(response.body);
        listPanier = panierFromJson(response.body);
        // print('idddddddPaaaaniiiiierr=====');
        // print(body[0]['Identifiant']);
        prefs.setString(idPanier, body[0]['Identifiant']);
        _prix = listPanier?[0].prixTtc;
        notifyListeners();
      } else {
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    }
  }

  getPanierSelected(String? id, BuildContext context) async {
    List<DetailMenuSelected> listPanierProvider;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      print(urlGetPanier);
      print(prefs.getString(idConst));
      print(urlPanierSelected + id!);
      final response = await http.get(
        Uri.parse(urlPanierSelected + id),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('iPANIER SELECTEEEEEED=====');
        var body = jsonDecode(response.body);
        print(response.body);
        listMenuSelected = detailMenuSelectedFromJson(response.body);

        notifyListeners();
      } else {
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    }
  }

  ajoutPanier(
      List sauceList,
      List tailleList,
      List viandeList,
      List boissonList,
      List garnitureList,
      int qt,
      String? idMenu,
      BuildContext context,
      String? idResto,
      String? img,
      String? name,
      int? numab,
      bool? like,
      int? rest) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: my_green,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.white));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(tokenconst);
      print("IC=IIIIIIiIIIII");
      print(tailleList);
      print(sauceList);
      print("IC=IIIIIIiIIIII");
      print(
        jsonEncode(
          {
            'extraPayload': {
              'linkedPanier': prefs.getString(idPanier),
              'linkedMenu': idMenu,
              'tailles': tailleList,
              'sauces': sauceList,
              'viandes': viandeList,
              'garnitures': garnitureList,
              'boisons': boissonList,
              'autres': [],
              'quantite': qt
            }
          },
        ),
      );
      final response = await http.post(
        Uri.parse(urlAjoutPaniert),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'extraPayload': {
              'linkedPanier': prefs.getString(idPanier),
              'linkedMenu': idMenu,
              'tailles': tailleList,
              'sauces': sauceList,
              'viandes': viandeList,
              'garnitures': garnitureList,
              'boisons': boissonList,
              'autres': [],
              'quantite': qt
            }
          },
        ),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Loader.hide();
        var body = jsonDecode(response.body);

        print(response.body);
        listPanier = panierFromJson(response.body);
        print('idddddddPaaaaniiiiierr=====');
        print(body[0]['Identifiant']);
        // Toast.show("Menu ajouté au panier!", context,
        //     duration: 1,
        //     gravity: 1,
        //     backgroundColor: Colors.grey.withOpacity(0.5));
        prefs.setString(idPanier, body[0]['Identifiant']);
        _prix = listPanier?[0].prixTtc;
        notifyListeners();
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
                          constraints: BoxConstraints(minHeight: 150.0),
                          //height: 200.h,
                          width: 150.w,
                          //padding: ,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                                    "Votre menu a été ajouté avec succès!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: my_green,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Text(
                                    "Voulez vous recommander le même menu?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
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
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        onPressed: () {
                                          //  press();
                                          Navigator.pop(context);
                                          //FadeTransition(opacity: , child: child);
                                        },
                                        child: Text("Oui",
                                            style: TextStyle(
                                                color: my_white,
                                                fontSize: 12.sp,
                                                fontFamily: "Roboto")),
                                      ),
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: 80.w,
                                      child: RaisedButton(
                                        elevation: 0.0,
                                        color: my_green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        onPressed: () {
                                          // press();
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: MenutScreen(
                                                dispo: true,
                                                numab: numab,
                                                id: idResto,
                                                img: img,
                                                name: name,
                                                like: like,
                                                qteRest: rest,
                                              ),
                                              type: PageTransitionType
                                                  .leftToRightWithFade,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.decelerate,
                                              reverseDuration: const Duration(
                                                  microseconds: 500),
                                            ),
                                          );
                                          //FadeTransition(opacity: , child: child);
                                        },
                                        child: Text("Non",
                                            style: TextStyle(
                                                color: my_white,
                                                fontSize: 12.sp,
                                                fontFamily: "Roboto")),
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
      } else {
        Loader.hide();
        print("Faild");
        print(response.statusCode);
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    }
  }

  updatePanier(
      List sauceList,
      List tailleList,
      List viandeList,
      List boissonList,
      List garnitureList,
      int qt,
      String? idMenuPanier,
      BuildContext context) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: my_green,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.white));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(tokenconst);
      print("IC=IIIIIIiIIIII");
      print(tailleList);
      print(sauceList);
      print("IC=IIIIIIiIIIII");
      print(
        jsonEncode(
          {
            'extraPayload': {
              'linkedMenuPanier': idMenuPanier,
              'tailles': tailleList,
              'sauces': sauceList,
              'viandes': viandeList,
              'garnitures': garnitureList,
              'boisons': boissonList,
              'autres': [],
              'quantite': qt
            }
          },
        ),
      );
      final response = await http.post(
        Uri.parse(urlUpdatePanier),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'extraPayload': {
              'linkedMenuPanier': idMenuPanier,
              'tailles': tailleList,
              'sauces': sauceList,
              'viandes': viandeList,
              'garnitures': garnitureList,
              'boisons': boissonList,
              'autres': [],
              'quantite': qt
            }
          },
        ),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Loader.hide();
        var body = jsonDecode(response.body);

        print(response.body);
        listPanier = panierFromJson(response.body);
        print('idddddddPaaaaniiiiierr=====');
        print(body[0]['Identifiant']);
        _prix = listPanier?[0].prixTtc;
        prefs.setString(idPanier, body[0]['Identifiant']);

        notifyListeners();
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
                      contentPadding: EdgeInsets.zero,
                      scrollable: true,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      content: Container(
                          constraints: BoxConstraints(minHeight: 60.0),
                          //height: 200.h,
                          width: 150.w,
                          padding: EdgeInsets.zero,
                          child: Stack(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Positioned(
                                  right: 0.w,
                                  top: 0.h,
                                  // padding: EdgeInsets.only(top: 2.h, right: 0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                  )),
                              Container(
                                padding:
                                    EdgeInsets.only(top: 40.h, bottom: 30.h),
                                child: Text(
                                    "Votre menu a été mis à jour avec succès!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: my_green,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                  ));
            });
      } else {
        Loader.hide();
        print("Faild");
        print(response.statusCode);
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    }
  }

  supprimerPanier(String? idMenu, BuildContext context) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: my_green,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.white));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(tokenconst);

      print(
        jsonEncode(
          {
            'extraPayload': {
              // 'linkedPanier': prefs.getString(idPanier),
              'linkedMenuPanier': idMenu,
            }
          },
        ),
      );
      final response = await http.post(
        Uri.parse(urlSuppPanier),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'extraPayload': {
              'linkedPanier': prefs.getString(idPanier),
              'linkedMenuPanier': idMenu,
            }
          },
        ),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Loader.hide();
        var body = jsonDecode(response.body);

        print(response.body);
        listPanier = panierFromJson(response.body);
        _prix = listPanier?[0].prixTtc;

        notifyListeners();
        print('idddddddPaaaaniiiiierr=====');
        print(body[0]['Identifiant']);
        // Toast.show("Menu ajouté au panier!", context,
        //     duration: 1,
        //     gravity: 1,
        //     backgroundColor: Colors.grey.withOpacity(0.5));
        prefs.setString(idPanier, body[0]['Identifiant']);
        getPanier(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LocationCommand()),
            (Route<dynamic> route) => false);
      } else {
        Loader.hide();
        print("Faild");
        print(response.statusCode);
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
                      contentPadding: EdgeInsets.zero,
                      scrollable: true,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      content: Container(
                          constraints: BoxConstraints(minHeight: 60.0),
                          //height: 200.h,
                          width: 150.w,
                          padding: EdgeInsets.zero,
                          child: Stack(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Positioned(
                                  right: 0.w,
                                  top: 0.h,
                                  // padding: EdgeInsets.only(top: 2.h, right: 0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                  )),
                              Container(
                                padding:
                                    EdgeInsets.only(top: 40.h, bottom: 30.h),
                                child: Text(
                                    "Votre menu a été mis à jour avec succès!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: my_green,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                  ));
            });
        // return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
    }
  }

  Future<bool> getListStation(BuildContext context, String? id, String? type,
      String? idCmd, bool isToday) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String typeDay = isToday ? "Now" : "Tomorrow";
      String url = idCmd == null
          ? "http://51.83.99.222:8077/getStationsDiponibles?type=$type&adresseLivrasion=$id&tempsLivraison=$typeDay"
          : "http://51.83.99.222:8077/getStationsDiponibles?type=$type&adresseLivrasion=$id&idPanier=$idCmd&tempsLivraison=$typeDay";
      print("iciiiiiii");
      print(url);
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        print('Liste Stations ===========>');
        var body = jsonDecode(response.body);
        print(response.body);
        listStations = listeStationFromJson(response.body);

        notifyListeners();

        return listStations?.listeStations?.length == 0 ? false : true;
      } else {
        print('hello');
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    }
  }

  creatCommande(BuildContext context, dayLiv, horaire, station, prix,
      List<double> position) async {
    try {
      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: my_green,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.white));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idpaniser = prefs.getString(idPanier);
      String? idClient = prefs.getString(idConst);
      String? token = prefs.getString(tokenconst);
      var data = {
        "extraPayload": {"panier": idpaniser, "client": idClient}
      };
      print(data);
      print(data);
      print(urlCmd);
      print(token);
      final response = await http.post(Uri.parse(urlCmd),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));
      print(response.body);
      if (response.statusCode == 200) {
        Loader.hide();
        print('Commande valide');
        var body = jsonDecode(response.body);
        print(response.body);
        prefs.setString(idCmd, body["idCommande"]);
        print(body["idCommande"]);
        print(prix);
        print(horaire);
        print(station);

        print(position);

        Navigator.push(
          context,
          PageTransition(
            child: StationsScreen(
              dayLiv: dayLiv,
              type: horaire,
              idAd: station,
              prix: prix,
              position: position,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(milliseconds: 1000),
          ),
        );
        notifyListeners();
      } else if (response.statusCode == 402) {
        var body = jsonDecode(response.body);
        String msg = body['message'];
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
                      contentPadding: EdgeInsets.zero,
                      scrollable: true,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      content: Container(
                          constraints: BoxConstraints(minHeight: 60.0),
                          height: 200.h,
                          width: 150.w,
                          padding: EdgeInsets.zero,
                          child: Stack(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Positioned(
                                  right: 0.w,
                                  top: 0.h,
                                  // padding: EdgeInsets.only(top: 2.h, right: 0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                  )),
                              SizedBox(height: 10.h),
                              Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Image.asset(
                                    'icons/warning.png',
                                    height: 60.h,
                                    width: 60.w,
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    // padding:
                                    //     EdgeInsets.only(top: 60.h, bottom: 30.h),
                                    child: Text(msg,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: my_green,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ));
            });
        Loader.hide();
        return false;
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    }
  }

  affecterAdressLivraisonCommande(
      BuildContext context,
      idlivreur,
      idStation,
      idtrajetCamion,
      linkedAdresseLivraison,
      prix,
      nameStation,
      nameLiv,
      depart,
      arrive) async {
    try {
      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: my_green,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.white));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idpaniser = prefs.getString(idPanier);
      String? idClient = prefs.getString(idPanier);
      String? token = prefs.getString(tokenconst);
      String? idCommande = prefs.getString(idCmd);
      var data = {
        "extraPayload": {
          "idCommande": idCommande,
          "livreur": idlivreur,
          "station": idStation,
          "trajetCamion": idtrajetCamion,
          "linkedAdresseLivraison": linkedAdresseLivraison
        }
      };
      print(data);
      print(urlCmd);
      print(token);
      final response = await http.post(Uri.parse(urlCmdUpdate),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));
      print(response.body);
      if (response.statusCode == 200) {
        Loader.hide();
        print('Commande valide');
        var body = jsonDecode(response.body);
        print(response.body);

        Navigator.push(
          context,
          PageTransition(
            child: RecapScreen(
              prix: prix,
              nameStation: nameStation,
              nameLiv: nameLiv,
              depart: depart,
              arrive: arrive,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(
              milliseconds: 300,
            ),
          ),
        );
        notifyListeners();
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return false;
      } else {
        Loader.hide();
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    }
  }

  getDefaultAdrress(String? id, BuildContext context) async {
    List<DetailMenuSelected> listPanierProvider;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // print(urlGetPanier);
      // print(prefs.getString(idConst));
      // print(urlPanierSelected + id!);
      final response = await http.get(
        Uri.parse(urlPanierSelected + id!),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // print('iPANIER SELECTEEEEEED=====');
        var body = jsonDecode(response.body);
        // print(response.body);
        adresseSelected = defaultAddressFromJson(response.body);

        notifyListeners();
      } else {
        return false;
      }
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    }
  }

  Future<bool> checkStation(
      String pos1, String pos2, BuildContext context) async {
    var data = {
      "position[0]": pos1,
      "position[1]": pos2,
    };
    print(data);
    try {
      final response = await http.post(
        Uri.parse(urlCheck),
        body: data,
        headers: <String, String>{
          // 'Content-Type': 'application/json',
        },
      );
      var body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        return body["result"];
      }
      if (response.statusCode == 400) {
        return body["result"];
      }
      return body["result"];
    } on SocketException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'vérifier votre conexion internet',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on TimeoutException {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'application a mit beacoup du temps pour repondre',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    } on Error catch (e) {
      Loader.hide();
      Navigator.pop(context);
      Toast.show(
        'Error',
        context,
        backgroundColor: Colors.black,
        gravity: 1,
        duration: 3,
      );
      return false;
    }
  }
}
