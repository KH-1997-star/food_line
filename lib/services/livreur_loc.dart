import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_line/models/livreur.dart';
import 'package:food_line/utils/const.dart';
import 'package:http/http.dart' as http;

class LivreurLocation {
  Future<Map<String, dynamic>> getLivreurPosition(String idLivreur) async {
    try {
      String urlGetLivreur = '${hostDynamique}read/$idLivreur';
      print(urlGetLivreur);
      var response = await http.get(
        Uri.parse(urlGetLivreur),
      );
      if (response.statusCode == 200) {
        print('Sucess');
        print(response.body);
        var body = jsonDecode(response.body);

        Livreur livreur;
        livreur = Livreur.fromJson(body[0]);
        print("=================> TRUUUUUUUE");
        print('livreur pos');
        print(livreur.position);
        return {
          'response': true,
          'lat': livreur.position?[0],
          'lng': livreur.position?[1],
        };
      } else {
        print(response.statusCode);
        return {
          'response': false,
          'message': erreurUlterieur,
        };
      }
    } catch (e) {
      print("=================> False");
      return {
        'response': false,
        'message': erreurCnx,
      };
    }
  }
}
