import 'package:flutter/cupertino.dart';
import 'package:food_line/models/detail_menu.dart';
import 'package:food_line/models/liste_promo_model.dart';
import 'package:food_line/models/liste_tags_model.dart';

import 'dart:convert';
import 'package:food_line/utils/const.dart';
import 'package:http/http.dart' as http;

class DetailMenuNotifier extends ChangeNotifier {
  String url = hostDynamique + "detailsMenu/";

  List<DetailMenu>? detailMenu;
  bool isSearch = false;
  ListeTags? listtags;
  ListePromo? listePromo;
  getDetailMenu(String? id) async {
    isSearch = false;
    String idspec = id ?? "";
    print("ID SPRC ===================> $idspec");
    List<DetailMenu> detailprod = [];
    print("ICIIIIIII**************");
    print(url + idspec);
    await http.get(Uri.parse(url + idspec)).then((response) {
      print(response.body);
      detailprod = List<DetailMenu>.from(
          json.decode(response.body).map((x) => DetailMenu.fromJson(x)));
      detailMenu = detailprod;
      print(detailMenu);
      notifyListeners();
    }).catchError((error) {
      print("ICIIIIIII2**************");
      detailMenu = null;

      isSearch = true;
      notifyListeners();
    });
  }
}
