import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:convert';
import 'package:food_line/models/profil.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/local_storage.dart';
import 'package:food_line/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<UserResponse?> getInfoClient(BuildContext context) async {
    print("********************* HELLO ****************");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // print("***********************IDDDDDDD********************");
    String? idAnonyme = prefs.getString("idAnonym");
    // print(prefs.getString(idConst));
    // print(prefs.getString(tokenconst));
    String id = prefs.getString(idConst) ?? "";
    String token = prefs.getString(tokenconst) ?? "";
    String? idClient = prefs.getString(nonCo) == "true"
        ? prefs.getString(idAnonym)
        : prefs.getString(idConst);
    String url =
        hostDynamique + "read/" + idClient! + "?vueAvancer=comptes_single";

    print(token + "/n" + id);

    UserResponse? userResponse;
    await http
        .get(
      Uri.parse(url),
    )
        .then((response) {
      // print(url);
      // print(response.body);
      if (response.statusCode == 200) {
        // print("****************hhhhhhhhdcbksqhdvkdfs");
        // print(response.body);
        var body = jsonDecode(response.body);
        // print("***********************Success********************");

        // print(body);
        userResponse = UserResponse.fromJson(json.decode(response.body)[0]);
        // print("****************");
        // print(userResponse!.toJson());
      } else if (response.statusCode == 401) {
        Navigator.pushNamed(context, "/login");
        Loader.hide();
      } else {}
    });
    return userResponse;
  }
}
