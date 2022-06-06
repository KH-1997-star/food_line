import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line/models/liste_promo_model.dart';
import 'package:food_line/models/liste_tags_model.dart';

import 'dart:convert';
import 'package:food_line/models/profil.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/local_storage.dart';
import 'package:food_line/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_line/models/liste_menu.dart';

class MenuNotifier extends ChangeNotifier {
  String url = hostDynamique + "listeMenusByRestaurants/";
  String urlLike = hostDynamique + 'api/client/likeResto';
  List<ListeMenu>? listMenu;
  bool isSearch = false;
  ListeTags? listtags;
  ListePromo? listePromo;
  listeMenu(String? id) async {
    isSearch = false;
    String idspec = id ?? "";
    print("ID SPRC ===================> $idspec");
    List<ListeMenu> detailprod = [];
    print("ICIIIIIII**************");
    print(url + idspec);
    await http.get(Uri.parse(url + idspec)).then((response) {
      print(response.body);
      print("ICIIIIIII**************");
      detailprod = listeMenuFromJson(response.body);

      listMenu = detailprod;
      print(listeMenuToJson(listMenu!));
      notifyListeners();
      // isSearch = true;
    }).catchError((error) {
      listMenu = null;

      isSearch = true;
      notifyListeners();
    });
  }

  lickerResto(String id, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    var data = {"idResto": id};
    var response = await http.post(Uri.parse(urlLike),
        headers: {'Authorization': 'Bearer $token'}, body: data);
    var body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 401) {
      Navigator.pushNamed(context, "/login");
      Loader.hide();
    }
  }
}
