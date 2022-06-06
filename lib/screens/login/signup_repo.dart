import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:food_line/models/user.dart';
import 'package:food_line/screens/login/signin_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:food_line/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:food_line/utils/const.dart';
import 'dart:convert';
import 'dart:io';
import 'activate_account.dart';

class SignUpViewModel extends ChangeNotifier {
  final url = hostDynamique + "inscription";
  static String urlTokenDevice = "${hostDynamique}api/client/setDeviceToken";

  final urlActiv = hostDynamique + "account/checkCodeActivationCompte";
  bool? _isLoading;
  String? _email;
  String? _password;
  String? _code;
  String? token;
  SignUpViewModel();
  bool get isLoading => _isLoading ?? false;
  String get email => _email ?? "false";
  String get password => _password ?? "false";
  String get code => _code ?? "false";
  set password(String password) {
    _password = email;
  }

  set code(String code) {
    _code = code;
  }

  User user = User();
  User get _user {
    if (user == null) {
      user = User(); // Instantiate the object if its null.
    }
    return user;
  }

  set email(String email) {
    _email = email;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  String typee = "";

  void resendCode(BuildContext context, String? email) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data = {"email": email};
    String url = hostDynamique + "reEnvoyerCodeActivation";
    print(data);
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("******************** SUCCESS **********************");
        print(response.body);
        Loader.hide();
        Toast.show("E-mail envoyé", context,
            backgroundColor: my_hint, duration: 2, gravity: 3);
      } else {
        Loader.hide();
        print("******************** FAILD **********************");
        print(response.body);
        Toast.show("Réessayer", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
      }
    } on SocketException {
      Loader.hide();
      print('**************** EXCEPTION*******************');
      Toast.show("Veuillez Vérifier votre conexion ", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
    } on HttpException {
      print('**************** EXCEPTION*******************');
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
    } on FormatException {
      print('**************** EXCEPTION*******************');
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
    }
  }

  void signUpWithEmailAndPassword(BuildContext context) async {
    print("***************************222222222222222***************");
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data;

    //  typee = "email";
    if (user.type == "email") {
      data = {
        "extraPayload": {
          'nom': user.name,
          'prenom': user.firstName,
          'phone': user.phone,
          'email': user.email,
          "ville": user.ville,
          "pays": user.pays,
          "codePostal": user.codePostal,
          'password': user.password,
          'type': user.type,
        }
      };
      print(data.toString());
    } else if (typee == "facebook" || typee == "google") {
      print("facebbboook");
      data = {
        "extraPayload": {
          'provider': "",
          'role': "ROLE_CLIENT",
          'nom': user.name,
          'prenom': user.firstName,
          'phone': user.phone,
          'email': user.email,
          'addresse': user.adress,
          'password': user.password,
          'type': user.type,
          'accesstoken': user.accessToken,
          'idUser': user.userId,
        }
      };
      print("***************************3333333333333***************");

      //print(data.toString());
    } else {
      print("google");
    }

    try {
      print(url);
      print(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data).toString());
      print(jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("******************** SUCCESS **********************");
        print(response.body);
        Loader.hide();
        print("iiiiiiiidididididididididid");
        print(jsonDecode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(idConst, jsonDecode(response.body));
        if (user.email != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivateAccountScreen(
                      email: user.email, mdp: user.password)));
        }
      } else {
        Loader.hide();
        print("******************** FAILD **********************");
        print(response.body);
        Toast.show("mail existant", context,
            backgroundColor: Colors.red, duration: 2, gravity: 3);
      }
    } on SocketException {
      Loader.hide();
      print('**************** EXCEPTION*******************');
      Toast.show("Veuillez Vérifier votre conexion ", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
    } on HttpException {
      print('**************** EXCEPTION*******************');
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
    } on FormatException {
      print('**************** EXCEPTION*******************');
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      Loader.hide();
    }
  }

  onChange({
    String? name,
    String? prenom,
    String? phone,
    String? email,
    String? address,
    String? sexe,
    String? password,
    String? poitrine,
    String? taille,
    String? size,
    String? hanches,
    String? stylePref,
    String? occasionPref,
    String? hauteur,
    String? type,
    String? userID,
    String? accessToken,
    String? zip,
    String? city,
    String? pays,
  }) {
    print("************** ICI1 ********************");
    print(type);
    user.ville = city;
    user.codePostal = zip;
    user.phone = phone;
    user.pays = pays;
    user.email = email;
    user.firstName = prenom;
    user.name = name;
    user.adress = address;
    user.password = password;
    user.sexe = sexe;

    print(userID);
    user.userId = userID;

    user.type = type;
    print(type);
    user.accessToken = accessToken;
    print("************** ICI 2********************");
  }

  singin(String mdp, email, BuildContext context) async {
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data = {"email": email, "password": mdp, "role": "ROLE_CLIENT"};
    print(data);
    try {
      var response = await http.post(Uri.parse(hostDynamique + "login"),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: data);

      if (response.statusCode == 200) {
        Loader.hide();
        var body = jsonDecode(response.body);
        String token = body["token"];
        String identifiant = body["identifiantMongo"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(idConst, identifiant);
        prefs.setString(tokenconst, token);

        if (prefs.getString(nonCo) == "true") {
          print("gggggggggggggggggggggggggg");
          ConnexionViewModel.affectPanierUserAnonymeToClient(context);
        } else {
          prefs.setString(nonCo, "false");
          print("***********************Success********************");
          Navigator.pushNamed(context, '/slide_screen');
        }
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
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      updateWith(isLoading: false);
      /* showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      updateWith(isLoading: false);
      /*  showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  void activateAccount(
      BuildContext context, String _email, String _code, String mdp) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));

    print("***************************1111111***************");
    updateWith(isLoading: true);
    var data = {"email": _email, "code": _code};
    print("************************************");
    print(data);
    print(urlActiv);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.post(Uri.parse(urlActiv), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //print(response.body);
        print(prefs.getString(nonCo));
        Loader.hide();
        singin(mdp, _email, context);
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
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      updateWith(isLoading: false);
      /* showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    } on FormatException {
      Loader.hide();
      Toast.show("Il semble qu'il a y eu un problème !", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      updateWith(isLoading: false);
      /*  showDialog(
          context: context,
          builder: (context) {
            return PopupEchec(context, 'Attention',
                "Il semble qu'il a y eu un problème.", () {});
          }); */
      print("Il semble qu'il a y eu un problème !.");
    }
  }

  setDeviceToken(BuildContext context) async {
    String? devicetoken = await FirebaseMessaging.instance.getToken();
    print(devicetoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(tokenconst);
    prefs.setString(nonCo, "false");
    var data = {"deviceToken": devicetoken};
    print("Deviiiiiiiiiiice token");
    print(data);
    var rem = prefs.getString(remember);
    print('helllloooooooooooooooo rememeber');
    print(rem);
    print(urlTokenDevice);
    var response = await http.post(Uri.parse(urlTokenDevice),
        headers: {'Authorization': 'Bearer $token'}, body: data);
    print(response.body);
    if (response.statusCode == 200) {
      print("hhhhhhhhhhdhdkbfshf");
      Navigator.pushNamed(context, '/slide_screen');
    }
  }

  updateWith({isLoading}) {
    this._isLoading = isLoading ?? this._isLoading;
    notifyListeners();
  }
}
