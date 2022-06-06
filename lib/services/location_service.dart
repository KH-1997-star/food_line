import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:food_line/models/commande_acheminement.dart';
import 'package:food_line/screens/Mes%20commandes/mes_commandes_screen.dart';
import 'package:food_line/screens/detect_livreur_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LocationService {
  final String url = "${hostDynamique}api/client/mesCommandesAcheminement/";
  final String key = 'AIzaSyDEeG_faGoRA6TOfNI2hcJ8JSHWiwmxSJA';
  Future<String> getPlaceId(String input) async {
    var placeId = '';

    String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var responce = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(responce.body);

    if (jsonData['status'] == "OK") {
      placeId = jsonData['candidates'][0]['place_id'] as String;
    } else if (input == '') {
      placeId = 'Requête ne peut pas etre vide';
    } else {
      placeId = '$input est introuvable dans la carte';
    }

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    Map<String, dynamic> result = {};
    var jsonData;
    try {
      String placeId = await getPlaceId(input);

      String url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
      var responce = await http.get(Uri.parse(url));
      print("helloooooo GOOGLE MAPSKIKOU1");
      jsonData = jsonDecode(responce.body);
      print(jsonData);
      print("helloooooo GOOGLE MAPSKIKOU2");
      if (jsonData['result'] == null) {
        input == ''
            ? result = {
                'result': 'Nom d\'une place ne peut pas être vide',
                'toast': true,
              }
            : result = {
                'result': '"$input"  n\'est pas reconnu par google map',
                'toast': true,
              };
      } else {
        print("GOOGLE BODY==========>");
        print(jsonData['result']['formatted_address']);
        print("helloooooo GOOGLE MAPS1111");
        result = {
          'result': jsonData['result']['geometry']['location'],
          'adresse':
              jsonData['result']['address_components'][0]['long_name'] ?? "",
          // 'ville':
          //     jsonData['result']['address_components'][1]['long_name'] ?? "",
          // 'codePostal': jsonData['result']['address_components'][5] == null
          //     ? ""
          //     : jsonData['result']['address_components'][5]['long_name'],
          'toast': false,
          'adress': jsonData['result']['formatted_address'],
        };
        print(result);
      }
    } on SocketException {
      result = {
        'result': 'vérifier votre conexion internet',
        'toast': true,
      };
      return result;
    } on TimeoutException {
      result = {
        'result': 'application a mit beacoup du temps pour repondre',
        'toast': true,
      };
      return result;
    } on Error catch (e) {
      result = {
        'result': "Adresse non valide",
        'toast': true,
      };
      return result;
    }
    return result;
  }

  CmdAcheminement? cmdAch;
  getStationNumber(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(idConst);
    String? token = prefs.getString(tokenconst);
    print(id);
    try {
      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: my_green,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.white));
      print(url + id!);
      await http.get(
        Uri.parse(url + id),
        headers: {"Authorization": "Bearer $token"},
      ).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          Loader.hide();
          cmdAch = cmdAcheminementFromJson(response.body);
          int x = cmdAch?.count ?? 0;
          if (x == 1) {
            print(cmdAch?.listeCommandes?[0].position);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetectLivreurScreen(
                        cmdId: cmdAch?.listeCommandes?[0].id ?? "",
                        id: cmdAch?.listeCommandes?[0].idLivreur ?? "",
                        positionList:
                            cmdAch?.listeCommandes?[0].position ?? [0])));
            //DetectLivreurScreen

          } else if (x > 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MesCommandeScreen()));
          } else {
            Toast.show(
              "Aucune commande n'est en cours",
              context,
              backgroundColor: Colors.red,
              gravity: 1,
              duration: 3,
            );
          }
        } else {
          Loader.hide();
        }
      });
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
    ;
  }
}
