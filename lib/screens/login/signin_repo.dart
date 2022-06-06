import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/models/user.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/location_screen.dart';
import 'package:food_line/screens/login/login_screen.dart';

import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/local_storage.dart';
import 'package:food_line/utils/validator.dart';
import 'package:food_line/widgets/custom_input.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;
import 'package:food_line/utils/const.dart';
import 'dart:convert';
import 'dart:io';

import '../livraison_quand_repo.dart';
import '../slide_screen.dart';

class ConnexionViewModel extends ChangeNotifier {
  final url = hostDynamique + "login";
  final String urlAnonyme = hostDynamique + "userAnonyme";
  static String urlAnonymeToClientPanier =
      hostDynamique + 'affecterPanierUserAnonymeToClient';
  static String urlTokenDevice = "${hostDynamique}api/client/setDeviceToken";
  static String urlLogout = "${hostDynamique}api/logout";
  bool? _isLoading;
  String? _email;
  String? _password;
  String? token;
  ConnexionViewModel();
  bool get isLoading => _isLoading ?? false;
  String get email => _email ?? "false";
  String get password => _password ?? "false";
  set password(String password) {
    _password = email;
  }

  set email(String email) {
    _email = email;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  MaskTextInputFormatter? maskFormatter = MaskTextInputFormatter(
      mask: '+33 # ## ## ## ##', filter: {"#": RegExp(r'[0-9]')});
  Future<void> signInMethod(
      {@required String? authProvider, @required BuildContext? context}) async {
    User userSignIn;

    print(authProvider);
    try {
      if (authProvider == "facebook") {
        userSignIn = await signInWithFacebook(context!);
      } else {
        userSignIn = await signInWithGoogle();

        print("???????????????????????? Google.????????????????????");
      }
      print("???????????????????????? Google2????????????????????");
      print(userSignIn);
      Loader.show(context!,
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: my_green,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.white));
      String isExist = await isUserExist(
          token: userSignIn.provider!.accessToken,
          idUser: userSignIn.provider!.userId,
          authProvider: userSignIn.authProvider,
          name: userSignIn.name,
          email: userSignIn.email);
      print(isExist);
      if (isExist == "IS_EXIST" || isExist == "IS_EXISTInscri") {
        /*   String token = userSignIn.accessToken;
        String identifiant = body["identifiantMongo"];
        StorageUtil.setSharedData(Constant.identifiant, identifiant); */
        // print("identifiant ${identifiant}");
        print(userSignIn.id);
        // Loader.hide();
        loginFbGoogle(
            exist: isExist,
            context: context,
            token: userSignIn.provider!.accessToken,
            idUser: userSignIn.provider!.userId,
            authProvider: userSignIn.authProvider);
      } else if (isExist == "NOT_FOUND") {
        Loader.hide();
        Toast.show("Il semble qu'il ya un problème", context,
            backgroundColor: Colors.red, duration: 2, gravity: 10);
        print("not Found");
        print(userSignIn.authProvider);
      } else {
        Loader.hide();
        print("Error11111");
      }
    } catch (e) {
      Loader.hide();
      // show Alert
    }
  }

  Future<String> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    return token!;
  }

  setDeviceTokenGoogle(BuildContext context, String? exist) async {
    String? devicetoken = await FirebaseMessaging.instance.getToken();
    print(devicetoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(tokenconst);

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
      String? connn = prefs.getString(nonCo);
      print(connn);
      if (connn == null) {
        print("NOOOOOOOOOO ANONYME ");
        prefs.setString(nonCo, "false");
      }

      if (prefs.getString(nonCo) == "true" && exist == "IS_EXIST") {
        //  print("ANONYme")
        affectPanierUserAnonymeToClient(context);
      } else if (prefs.getString(nonCo) == "true" &&
          exist == "IS_EXISTInscri") {
        affectPanierUserAnonymeToClient(context);
      } else {
        prefs.setString(nonCo, "false");
        print("***********************Success********************");
        if (exist == "IS_EXIST") {
          print("ISSSSSSSSS EXIIIIIST=======>");

          setDeviceToken(context);
        } else if (exist == "IS_EXISTInscri") {
          Loader.hide();
          print("ISSSSSSSSS inscrriiiiiii=======>");
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (context, StateSetter setState) {
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
                              constraints: BoxConstraints(minHeight: 250.0),
                              //height: 200.h,
                              width: 250.w,
                              //padding: ,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Veuillez entrer votre numéro de téléphone ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomInput(
                                          width: 200.w,
                                          isphone: true,
                                          texte: 'Numéro de téléphone',
                                          formater: maskFormatter,
                                          //  formater: [],
                                          keyboardType: TextInputType.number,
                                          onTap: () {
                                            setState(() {
                                              enablphone = true;
                                            });
                                          },
                                          enableField: enablphone,
                                          hintText: "+33 0 00 00 00 00 ",
                                          controller: phoneController,
                                          validator: (String? v) {
                                            return Validators.validatePhone(v!);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 200.w,
                                    color: my_green,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(my_green),
                                      ),
                                      onPressed: () {
                                        // widget.onChange!(temp);
                                        // print(temp);
                                        // setState(() {
                                        //   widget.horaire = temp;
                                        //   getStations(temp);
                                        // });
                                        print("hhhhhh");
                                        TempsLivNotifier.setNumPhone(
                                            phoneController.text, context)();
                                      },
                                      child: Text("Confirmer",
                                          style: TextStyle(
                                              color: my_white,
                                              fontSize: 12.sp,
                                              fontFamily: "Roboto")),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ));
                });
              });
        }
      }
    }
  }

  setDeviceToken(BuildContext context) async {
    String? devicetoken = await FirebaseMessaging.instance.getToken();
    print(devicetoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(tokenconst);
    var data = {"deviceToken": devicetoken};

    var rem = prefs.getString(remember);

    var response = await http.post(Uri.parse(urlTokenDevice),
        headers: {'Authorization': 'Bearer $token'}, body: data);
    String? connn = prefs.getString(nonCo);
    if (connn == null) {
      prefs.setString(nonCo, "false");
    }
    if (response.statusCode == 200) {
      if (prefs.getString(nonCo) == "true") {
        affectPanierUserAnonymeToClient(context);
      } else {
        Loader.hide();
        print("***********************Success********************");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                isFirstTime: rem == true.toString() ? false : true,
              ),
            ));
      }
    }
  }

  setDeviceTokenPanier(String token, String id, BuildContext context) async {
    String? devicetoken = await FirebaseMessaging.instance.getToken();
    print(devicetoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = {"deviceToken": devicetoken};
    print(data);
    var rem = prefs.getString(remember);
    print(rem);
    print(urlTokenDevice);
    var response = await http.post(Uri.parse(urlTokenDevice),
        headers: {'Authorization': 'Bearer $token'}, body: data);
    print(response.body);
    if (response.statusCode == 200) {
      String? connn = prefs.getString(nonCo);
      print(connn);
      if (connn == null) {
        prefs.setString(nonCo, "false");
      }
      if (prefs.getString(nonCo) == "true") {
        affectPanierUserAnonymeToClientAdree(context);
      } else {
        print("***********************Success********************");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LocationScreen(token: token, id: id, isLogin: true)));
      }
    }
  }

  static signOut(BuildContext context) async {
    String? devicetoken = await FirebaseMessaging.instance.getToken();
    print(devicetoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(tokenconst);
    print(token);
    var data = {"deviceToken": devicetoken};
    print(data);

    var response = await http.post(Uri.parse(urlLogout),
        headers: {'Authorization': 'Bearer $token'}, body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      Loader.hide();
      print("hhhhhhhhhhdhdkbfshf");
      SharedPreferences? _prefs;
      print("1");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("2");
      prefs.remove(idConst);
      prefs.remove(tokenconst);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }

  TextEditingController phoneController = TextEditingController();
  bool enablphone = false;
  Future<void> loginFbGoogle({
    BuildContext? context,
    String? token,
    String? idUser,
    String? authProvider,
    String? exist,
  }) async {
    var data = {
      'type': authProvider,
      'accessToken': token,
      'idUser': idUser,
    };
    print("¤¤¤¤¤¤${data}¤¤¤¤¤");

    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: data);
      var body = jsonDecode(response.body);
      print(body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        String token = body["token"];
        String identifiant = body["identifiantMongo"];
        print("***********************Success********************");
        print(body);

        SharedPreferences? _prefs;

        prefs.setString(idConst, identifiant);
        prefs.setString(tokenconst, token);

        String message = body["message"];
        print(body["message"]);

        if (body["message"] == "login success") {
          setDeviceTokenGoogle(context!, exist);
        } else {
          Loader.hide();
          print("***********************FAILD********************");
          Toast.show(message, context, duration: 1, gravity: 1);
        }
      } else {
        Loader.hide();
        updateWith(isLoading: false);
        print(
            "**********************Il semble qu'il a y eu un problème.********");
        Toast.show('Veuillez vérifier vos identifiants', context,
            backgroundColor: Colors.red, duration: 2, gravity: 10);
        //  }

      }
    } on SocketException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on HttpException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on FormatException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    }
  }

  Future<String> isUserExist(
      {String? token,
      String? idUser,
      String? authProvider,
      String? email,
      String? name}) async {
    print("type    $authProvider" + 'accessToken   $token' + 'idUser $idUser');
    var data = {
      "extraPayload": {
        'type': authProvider,
        'accessToken': token,
        'idUser': idUser,
        "nom": name,
        "prenom": "",
        "email": email,
        "role": "ROLE_CLIENT"
      }
    };

    print("¤¤¤¤¤¤${data}¤¤¤¤¤");

    try {
      var response = await http.post(
          Uri.parse(hostDynamique + "inscriptionDirect"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data).toString());
      var body = jsonDecode(response.body);

      ///   if(response.statusCode == 200 || response.statusCode == 201){
      print("========>${body}");
      String message = body["message"];

      if (message.trim() == "Access token invalide".trim()) {
        return "NOT_FOUND";
        // showDialog(context: context,builder: (context){
        //     return PopupSuccessInscription(context, "Succès", "Votre compte a été créé avec succès.Un e-mail a été envoyé à votre adresse de contact pour l'activer !");
        //    });
      } else if (message.trim() == "compte valide".trim()) {
        print(body.toString());
        // await saveToken(body["token"]);
        String identifiant = body["identifiantMongo"];
        //StorageUtil.setSharedData(Constant.identifiant, identifiant);
        print("********************IS EXIST?*****************");
        print("IS_EXIST");
        return "IS_EXIST";
      } else if (message.trim() == "inscription avec success".trim()) {
        print(body.toString());
        // await saveToken(body["token"]);
        String identifiant = body["identifiantMongo"];
        //StorageUtil.setSharedData(Constant.identifiant, identifiant);
        print("********************IS EXIST?*****************");
        print("IS_EXIST");
        return "IS_EXISTInscri";
      } else if (message.trim() == "email déja utilisé".trim()) {
        print("NOT_FOUND");
        return "NOT_FOUND";
      } else {
        return "NOT_FOUND";
        // showDialog(context: context,builder: (context){
        //return  PopupEchec(context, "Attention", "Il semble qu'il a y eu un problème !" );

        // });

      }
      //  }

    } on SocketException {
      return "ERROR";
    } on HttpException {
      return "ERROR";
    } on FormatException {
      return "ERROR";
    }
  }

  User user = User();

  Future<User> signInWithGoogle() async {
    final _googleSignIn = GoogleSignIn();
    print("********* Google1******************");

    GoogleSignInAccount? googleSignInAccountData = await _googleSignIn.signIn();
    print("********* Google2******************");
    final googleAuth = await googleSignInAccountData!.authentication;
    print("idToken============>" + jsonEncode(googleAuth.idToken));
    print("AccessToken============>" + jsonEncode(googleAuth.accessToken));
    print("********* Google2******************");

    user.provider = AuthProvider(
        accessToken: googleAuth.accessToken!,
        userId: googleSignInAccountData.id,
        type: googleAuth.idToken!);
    user.email = googleSignInAccountData.email;
    user.name = googleSignInAccountData.displayName;
    user.authProvider = "google";
    print(user.toJson().toString());
    return user;
  }

  Future<User> signInWithFacebook(BuildContext context) async {
    try {
      var _accessToken = await FacebookAuth.instance
          .login(); // by the fault we request the email and the public profile
      final userData =
          await FacebookAuth.instance.getUserData(fields: "name,email");
      print(userData);
      user.provider = AuthProvider(
          accessToken: _accessToken.accessToken!.token,
          userId: userData["id"],
          type: "facebook");
      user.name = userData['name'];
      user.email = userData['email'];
      user.authProvider = "facebook";
      //  print(user.toJson().toString());
      return user;
      // Navigator.pushReplacementNamed(context, '/InscriptionFB');
      // } on FacebookAuthException catch (e) {
      //   throw PlatformException(
      //     code: e.errorCode,
      //     message: e.message,
      //   );
    } catch (e, s) {
      throw PlatformException(
        code: "0",
        message: e.toString(),
      );
    }
  }

  signInAnonymos(BuildContext context) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    try {
      var data = {
        "extraPayload": {
          'nom': "anonymous",
          'email': "email",
          'prenom': "prenom",
          "role": "ROLE_ANONYMOUS",
        }
      };
      var response = await http.post(Uri.parse(urlAnonyme),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      var body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        Loader.hide();
        var body = jsonDecode(response.body);
        print("***********************Success********************");

        print(body);
        String token = body["token"];
        String idAnonyme = body["identifiantAnonyme"];
        SharedPreferences? _prefs;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(idAnonym, idAnonyme);
        print("Anonyyyymmmmeeee****************");
        print(prefs.getString(idAnonym));
        print("Anonyyyymmmmeeee****************");
        prefs.setString(nonCo, "true");
        print(prefs.getString(nonCo));
        print("***********************Success********************");
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const SlideScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(
              milliseconds: 500,
            ),
          ),
        );
        //Navigator.pushNamed(context, "/home_screen");
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     child: HomePage(),
        //     type: PageTransitionType.fade,
        //     duration: Duration(
        //       milliseconds: 1500,
        //     ),
        //   ),
        // );

      } else {
        Loader.hide();
        updateWith(isLoading: false);
        print(
            "**********************Il semble qu'il a y eu un problème.********");
        Toast.show('Veuillez vérifier vos identifiants', context,
            backgroundColor: Colors.red, duration: 2, gravity: 10);
        //  }

      }
    } on SocketException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on HttpException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on FormatException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    }
  }

  signInWithEmailAndPassword(BuildContext context) async {
    updateWith(isLoading: true);
    Loader.show(context,
        progressIndicator: const CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    var data = {"email": _email, "password": _password, "role": "ROLE_CLIENT"};
    String message = "";
    print(data);
    print(url);
    try {
      print("TRYYYYY");
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: data);
      print(response.body);
      if (response.statusCode == 200) {
        Loader.hide();
        var body = jsonDecode(response.body);
        String token = body["token"];
        String identifiant = body["identifiantMongo"];
        print(body["checkAdresseLivraison"]);
        print(body["checkAdresseLivraison"] == true);
        print("***********************Success********************");
        if (body["checkAdresseLivraison"] == true) {
          print(body);

          SharedPreferences? _prefs;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(idConst, identifiant);
          prefs.setString(tokenconst, token);
          print("***********************IDDDDDDD********************");

          print(prefs.getString(idConst));
          print(prefs.getString(tokenconst));

          message = body["message"];
          print(body["message"]);

          updateWith(isLoading: false);
          if (body["message"] == "login success") {
            Loader.hide();
            setDeviceToken(context);
          } else {
            Loader.hide();
            print("***********************FAILD********************");
            Toast.show(message, context, duration: 1, gravity: 1);
          }
        } else {
          print("MAPPPPPPPPPPPPPP");
          setDeviceTokenPanier(token, identifiant, context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => LocationScreen(
          //             token: token, id: identifiant, isLogin: true)));
        }
      } else {
        Loader.hide();
        updateWith(isLoading: false);
        print(
            "**********************Il semble qu'il a y eu un problème.********");
        Toast.show('Veuillez vérifier vos identifiants', context,
            backgroundColor: Colors.red, duration: 2, gravity: 10);
      }
    } on SocketException {
      Loader.hide();
      updateWith(isLoading: false);
      Toast.show("Vérifier votre connexion Internet", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      print("********************** CNX INTERNET *********************");
    } on HttpException {
      Loader.hide();
      Toast.show("Il semble qu'il y a un problèmr", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
      updateWith(isLoading: false);
      print("***************************** PB ********************");
    } on FormatException {
      Loader.hide();
      updateWith(isLoading: false);
      print("************************* PB**********************");
      Toast.show("Il semble qu'il y a un problème", context,
          backgroundColor: Colors.red, duration: 2, gravity: 3);
    } catch (e) {
      Loader.hide();
      print(e);
      return null;
    }
    return message;
  }

  updateWith({isLoading}) {
    this._isLoading = isLoading ?? this._isLoading;
    notifyListeners();
  }

  navigateToNextPage(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  onChangeData({email, password}) {
    print("HIIIII");
    _email = email;
    _password = password;
  }

  static affectPanierUserAnonymeToClient(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(idAnonym));
    prefs.getString(idAnonym);
    var data = {
      'idMongo': prefs.getString(idConst),
      'idAnonyme': prefs.getString(idAnonym),
    };
    print("¤¤¤¤¤¤${data}¤¤¤¤¤");

    try {
      var response =
          await http.post(Uri.parse(urlAnonymeToClientPanier), body: data);
      var body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        Loader.hide();
        print("***********************SuccessANONYME********************");

        var body = jsonDecode(response.body);

        print(body);

        String message = body["message"];

        print(message);

        if (body["message"] == "done") {
          Loader.hide();

          prefs.setString(nonCo, "false");
          print("***********************Success********************");
          Navigator.pushNamed(context, '/location_command_screen');

          // Navigator.push(
          //   context,
          //   PageTransition(
          //     child: HomePage(),
          //     type: PageTransitionType.fade,
          //     duration: Duration(
          //       milliseconds: 1500,
          //     ),
          //   ),
          // );
        } else {
          Loader.hide();
          print("***********************FAILD********************");
          Toast.show(message, context, duration: 1, gravity: 1);
        }
      } else {
        Loader.hide();
        print("***********************SuccessANONYME11111********************");

        print(
            "**********************Il semble qu'il a y eu un problème.********");
        Toast.show('Veuillez vérifier vos identifiants', context,
            backgroundColor: Colors.red, duration: 2, gravity: 10);
        //  }

      }
    } on SocketException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on HttpException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on FormatException {
      Loader.hide();
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    }
  }

  static affectPanierUserAnonymeToClientAdree(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(idAnonym));
    prefs.getString(idAnonym);
    var data = {
      'idMongo': prefs.getString(idConst),
      'idAnonyme': prefs.getString(idAnonym),
    };
    print("¤¤¤¤¤¤${data}¤¤¤¤¤");

    try {
      var response =
          await http.post(Uri.parse(urlAnonymeToClientPanier), body: data);
      var body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        Loader.hide();
        print("***********************SuccessANONYME********************");

        var body = jsonDecode(response.body);

        print(body);

        String message = body["message"];

        print(message);

        if (body["message"] == "done") {
          Loader.hide();
          prefs.setString(nonCo, "false");
          print("***********************Success********************");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => LocationScreen(
          //             token: token, id: identifiant, isLogin: true)));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationCommand(),
              ));
          // Navigator.pushNamed(
          //     context, '/location_command_screen'); // Navigator.push(
          //   context,
          //   PageTransition(
          //     child: HomePage(),
          //     type: PageTransitionType.fade,
          //     duration: Duration(
          //       milliseconds: 1500,
          //     ),
          //   ),
          // );
        } else {
          Loader.hide();
          print("***********************FAILD********************");
          Toast.show(message, context, duration: 1, gravity: 1);
        }
      } else {
        Loader.hide();
        print("***********************SuccessANONYME11111********************");

        print(
            "**********************Il semble qu'il a y eu un problème.********");
        Toast.show('Veuillez vérifier vos identifiants', context,
            backgroundColor: Colors.red, duration: 2, gravity: 10);
        //  }

      }
    } on SocketException {
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on HttpException {
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    } on FormatException {
      print(
          "**********************Il semble qu'il a y eu un problème.********");
      Toast.show("Il semble qu'il a y eu un problème.", context,
          backgroundColor: Colors.red, duration: 2, gravity: 10);
    }
  }
}
