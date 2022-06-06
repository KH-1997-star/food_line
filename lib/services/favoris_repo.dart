import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_line/models/favoris.dart';
import 'package:food_line/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FavorisRepo extends ChangeNotifier {
  Future<Map<String, dynamic>> getFavoris() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString(idConst);
      String favorisUrl =
          '${hostDynamique}readAll/favoris?compte=$id&indexVue=CLIENT&vueAvancer=favoris_multi';
      print(favorisUrl);
      var response = await http.get(
        Uri.parse(favorisUrl),
      );
      if (response.statusCode == 200) {
        Favoris favoris = Favoris.fromJson(jsonDecode(response.body));
        print(favoris.results?[0].restaurant);
        return {'result': true, 'data': favoris};
      } else {
        print(response.statusCode);
        return {'result': false, 'message': erreurUlterieur};
      }
    } catch (e) {
      return {'result': false, 'message': erreurUlterieur};
    }
  }
}
