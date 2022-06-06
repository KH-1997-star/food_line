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
import 'package:food_line/models/liste_resto_model.dart';

class RestoNotifier extends ChangeNotifier {
  String url = hostDynamique + "listeRestaurants?identifiantMongo=";
  String urltags = hostDynamique +
      "readAll/specialites?isActive=1&vueAvancer=specialites_multi";
  String urlPromo = hostDynamique +
      "readAll/promotions?isActive=1&vueAvancer=promotions_multi";
  String urlSearch = hostDynamique + "searcheAvancer";
  List<ListeResto>? listResto;
  bool isSearch = false;
  ListeTags? listtags;
  ListePromo? listePromo;
  listeResto(String? id) async {
    isSearch = false;
    String idspec = id == "" ? "" : "$id";
    List<ListeResto> detailprod = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);
    print(prefs.getString(nonCo));
    String? idMongo = prefs.getString(nonCo) == "true"
        ? prefs.getString(idAnonym)
        : prefs.getString(idConst);
    print(url + '$idMongo' + idspec);

    await http
        .get(
      Uri.parse(url + '$idMongo' + idspec),
    )
        .then((response) {
      detailprod = listeRestoFromJson(response.body);

      listResto = detailprod;
      notifyListeners();
    }).catchError((error) {
      listResto = null;

      isSearch = true;
      notifyListeners();
    });
  }

  loadingListTags() async {
    isSearch = false;
    ListeTags? listspec;

    await http.get(Uri.parse(urltags)).then((response) {
      if (response.statusCode == 200) {
        listspec = ListeTags.fromJson(json.decode(response.body));
        listtags = listspec;
        notifyListeners();
      } else {
        print("ERROR");
      }
    }).catchError((error) {
      print("ERROR**************");
      listtags = null;
      isSearch = true;
      notifyListeners();
    });
  }

  loadingListPromos() async {
    isSearch = false;
    ListePromo? listspec;
    print(url);

    await http.get(Uri.parse(urlPromo)).then((response) {
      if (response.statusCode == 200) {
        listspec = ListePromo.fromJson(json.decode(response.body));
        listePromo = listspec;
        notifyListeners();
      } else {
        print("ERROR");
      }
    }).catchError((error) {
      print("ERROR**************");
      listePromo = null;
      isSearch = true;
      notifyListeners();
    });
  }

  searchlisteResto(String? word) async {
    isSearch = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idMongo = prefs.getString(nonCo) == "true"
        ? prefs.getString(idAnonym)
        : prefs.getString(idConst);
    print("Word ===================> $word");
    List<ListeResto> detailprod = [];
    print("ICIIIIIII**************");
    print(urlSearch);
    var data = {"word": word, "identifiantMongo": idMongo};
    await http.post(Uri.parse(urlSearch), body: data).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        detailprod = listeRestoFromJson(response.body);

        listResto = detailprod;

        notifyListeners();
        print(listResto);
      }
    }).catchError((error) {
      listResto = null;

      isSearch = true;
      notifyListeners();
    });
  }
}
