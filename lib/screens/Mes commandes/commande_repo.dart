import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:food_line/models/commande_details_livreur.dart';
import 'package:food_line/models/commande_details_model.dart';
import 'package:food_line/models/commande_details_station.dart';
import 'package:food_line/models/commande_menu.dart';
import 'package:food_line/models/commande_status_model.dart';
import 'package:food_line/models/liste_commande.dart';
import 'package:food_line/models/station.dart';
import 'package:food_line/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CommandeNotifier extends ChangeNotifier {
  List<DetailStation>? detailStation;
  static const String urlGetListeCmd =
      '${hostDynamique}api/client/readAll/commandes?statutPaiement=payed&details=livreur,photoProfil&linkedCompte=';
  static const String urlGetStatusCmd =
      '${hostDynamique}api/client/readAll/etatsCommandes?commande=';
  static const String urlGetDetailsCmd =
      '?vueAvancer=commandes_single&indexVue=CLIENT';
  static const String urlGetDetailsCmdLivreur =
      "?version=2&details=livreur,photoProfil";
  static const String urlGetDetailsCmdMenu =
      "${hostDynamique}api/client/detailsCommande/";
  static const String urlGetDetailsCmdStation =
      "api/client/readAll/commandes?details=station&linkedCompte=";
  // http://51.83.99.222:8077/read/620b6a39c4c88a129679a592?vueAvancer=commandes_single&indexVue=CLIENT
//   static const String urlAjoutPaniert = '${hostDynamique}ajoutMenuAuPanier';
//   static const String urlPanierSelected = '${hostDynamique}read/';
//   static const String urlUpdatePanier = '${hostDynamique}updateMenuAuPanier';
//   static const String urlSuppPanier = '${hostDynamique}removeProduitFromPanier';
  ListeCmd? listCmd;
  CommandeStatus? statusCmd;
  List<CommandeDetails>? detailsCmd;
  List<CommandeDetailsLivreur>? detailsCmdLivreur;
  List<CommandeDetailsStation>? detailsCmdStation;
  CommandeMenu? detailsCmdMenu;

  listCommande(BuildContext context) async {
    // List<ListeCmd> listPanierProvider;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    String? id = prefs.getString(idConst);
    print(token);
//     String? idAnonyme = prefs.getString("idAnonym");
//     print('MYIDDDDDD//: $id');
//     print(urlGetPanier);
//     print("Anonyyyymmmmeeee****************");
//     print(idAnonyme);
//     print("Anonyyyymmmmeeee****************");
//     print(prefs.getString(idConst));
//     print(prefs.getString(idAnonym));
//     print(prefs.getString(nonCo));
    print(urlGetListeCmd + id!);

    try {
      final response = await http.get(
        Uri.parse(urlGetListeCmd + id),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        // body: jsonEncode(
        //   {
        //     'extraPayload': {
        //       'linkedCompte': prefs.getString(nonCo) == "true"
        //           ? prefs.getString(idAnonym)
        //           : prefs.getString(idConst),
        //       'statut': 'active',
        //     }
        //   },
        // ),
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print("bodyyyyyy========>");
        print(response.body);
        listCmd = ListeCmd.fromJson(json.decode(response.body));
        print('HELLOOOOOOOOO======>');
        notifyListeners();
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");

        Loader.hide();
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

  Future<Map<String, dynamic>> getPositionStation(
      String idStation, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(tokenconst);
      String? id = prefs.getString(idConst);
      print('URL KHHAYRI');
      var url = '${hostDynamique}read/$idStation?details=station';
      print(url);
      var response = await http.get(
        Uri.parse(
          '${hostDynamique}read/$idStation?details=station',
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print('BOOODY KH');
        print(response.body);
        detailStation = List<DetailStation>.from(
            json.decode(response.body).map((x) => DetailStation.fromJson(x)));
        ;
        return {
          'response': true,
          'data': detailStation?[0].station?[0].position,
          'position': detailStation?[0].station?[0].name
        };
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return {"stat": false};
      } else {
        return {
          'response': false,
          'data': [0, 0],
          'message': erreurUlterieur,
        };
      }
    } catch (e) {
      return {
        'response': false,
        'data': [0, 0],
        'message': erreurCnx,
      };
    }
  }

  statusCommande(String idCmd, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    String? id = prefs.getString(idConst);
    print(token);
    try {
      print(urlGetStatusCmd + idCmd);
      final response = await http.get(
        Uri.parse(urlGetStatusCmd + idCmd),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print("bodyyyyyy========>");
        print(response.body);
        statusCmd = CommandeStatus.fromJson(json.decode(response.body));

        notifyListeners();
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return false;
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

  detailsCommande(String idCmd, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    String? id = prefs.getString(idConst);
    print(token);
    print("hhhhhhhhhhhh");
    print('${hostDynamique}read/$idCmd$urlGetDetailsCmd');
    try {
      final response = await http.get(
        Uri.parse('${hostDynamique}read/$idCmd$urlGetDetailsCmd'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print("bodyyyyyy========>Details ");
        print(response.body);
        detailsCmd = List<CommandeDetails>.from(
            json.decode(response.body).map((x) => CommandeDetails.fromJson(x)));

        notifyListeners();
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return false;
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

  detailsCommandeMenu(String idCmd, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    String? id = prefs.getString(idConst);
    print(token);
    print("Link To commande menus ");
    print('$urlGetDetailsCmdMenu$idCmd');
    try {
      final response = await http.get(
        Uri.parse('$urlGetDetailsCmdMenu$idCmd'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print("bodyyyyyy========>Details ");
        print(response.body);
        detailsCmdMenu = CommandeMenu.fromJson(json.decode(response.body));

        notifyListeners();
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return false;
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

  detailsCommandeLivreur(String idCmd, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    String? id = prefs.getString(idConst);
    print(token);
    print("hhhhhhhhhhhh");
    print('${hostDynamique}$urlGetDetailsCmdLivreur$idCmd');
    try {
      final response = await http.get(
        Uri.parse('${hostDynamique}read/$idCmd$urlGetDetailsCmdLivreur'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print("bodyyyyyy========>Details ");
        print(response.body);
        detailsCmdLivreur = List<CommandeDetailsLivreur>.from(json
            .decode(response.body)
            .map((x) => CommandeDetailsLivreur.fromJson(x)));

        notifyListeners();
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return false;
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

  detailsCommandeStation(String idCmd, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    String? id = prefs.getString(idConst);
    print(token);
    print("hhhhhhhhhhhh");
    print('${hostDynamique}read/$urlGetDetailsCmdStation$idCmd');
    try {
      final response = await http.get(
        Uri.parse('${hostDynamique}read/$urlGetDetailsCmdStation$idCmd'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print("bodyyyyyy========>Details ");
        print(response.body);
        detailsCmdStation = List<CommandeDetailsStation>.from(json
            .decode(response.body)
            .map((x) => CommandeDetailsStation.fromJson(x)));

        notifyListeners();
      }
      if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
        return false;
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
}
