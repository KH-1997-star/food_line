import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_line/screens/GererProfil/gerer_profil_screen.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/qr_code_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/titre_food_line_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../payment_screen.dart';

final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);

class RecapScreen extends ConsumerStatefulWidget {
  final bool? ishome;
  final String? idStation;
  final String? prix;
  final String? nameStation;
  final String? nameLiv;
  final String? arrive;
  final String? depart;
  const RecapScreen(
      {Key? key,
      this.nameLiv,
      this.nameStation,
      this.ishome = false,
      this.prix,
      this.arrive,
      this.depart,
      this.idStation})
      : super(key: key);

  @override
  _RecapScreenState createState() => _RecapScreenState();
}

class _RecapScreenState extends ConsumerState<RecapScreen> {
  String? horaire;
  String? heure;
  String? dayLiv;
  bool isLoading = true;
  Map<String, dynamic>? paymentIntentData;
  getHoraire() async {
    //var Timenow = DateFormat.Hm().format(currentTime);

    final viewModel = ref.read(profilProvider);
    await viewModel.getInfoClient(context).then(
      (value) {
        setState(() {
          dayLiv = value?.timeLivraison ?? "";

          print("iciiiiiiii dayLiv    $dayLiv");
          horaire = value?.tempsLivraison ?? "";
          if (horaire == "Midi") {
            heure = "11h";
            var heureMin = 660;

            // diff = print(diff);
          } else if (horaire == "Soir") {
            heure = "15h";
            var heureMin = 900;
          } else {
            heure = "17h";
            var heureMin = 1020;
          }
        });
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHoraire();
    print(widget.nameStation);
    print(widget.nameLiv);
    print(horaire);
    print(widget.prix);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 36.h,
            ),
            Row(
              children: [
                SizedBox(width: 36.w),
                MyWidgetButton(
                    widget: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  width: 82.w,
                ),
                Text(
                  'Récapitulatif',
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 45.h,
            ),
            SizedBox(
              height: 39.h,
            ),
            SizedBox(
              height: 500,
              child: Padding(
                padding: EdgeInsets.only(right: 36.w, left: 39.w, bottom: 16.h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Votre commande a été confirmée avec succés. Avant de précéder au paiement, voici un petit récapitulatif:   ',
                        style: TextStyle(fontSize: 16.sp, height: 2),
                        textAlign: TextAlign.left,
                      ),
                      RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.black, height: 2),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Vous allez être livré dans la station ',
                                style: TextStyle(fontSize: 16.sp)),
                            TextSpan(
                                text: '${widget.nameStation}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp)),
                            TextSpan(
                                text: ' à ', style: TextStyle(fontSize: 16.sp)),
                            TextSpan(
                                text: '${horaire} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp)),
                            TextSpan(
                                text: ' entre ',
                                style: TextStyle(fontSize: 16.sp)),
                            TextSpan(
                                text: '${widget.arrive} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp)),
                            TextSpan(
                                text: ' et ',
                                style: TextStyle(fontSize: 16.sp)),
                            TextSpan(
                                text: '${widget.depart} .',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        width: 600,
                        child: RichText(
                          text: TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Votre livreur est ',
                                  style: TextStyle(fontSize: 16.sp)),
                              TextSpan(
                                  text: '${widget.nameLiv}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MyWidgetButton(
                  widget: CommanderWidget(
                    title: "Payer",
                    titleLeftPadding: 41,
                    priceLeftPadding: 24,
                    myPrice: '${widget.prix}',
                  ),
                  onTap: () async {
                    print('IDLIVREUR');
                    await makePayment();
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     child: PaymentScreen(prix: widget.prix),
                    //     type: PageTransitionType.fade,
                    //     duration: const Duration(
                    //       milliseconds: 300,
                    //     ),
                    //   ),
                    // );
                    // print(idlivreur);

                    // viewModel.affecterAdressLivraisonCommande(
                    //     context,
                    //     viewModel.listStations?.listeStations?[index!]
                    //         .livreur?.identifiant,
                    //     viewModel.listStations?.listeStations?[index!]
                    //         .idStation,
                    //     viewModel.listStations?.listeStations?[index!]
                    //         .trajetCamion,
                    //     widget.idAd,
                    //     widget.prix);
                  },
                  color: Colors.black,
                  width: 303,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: my_green,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.white));
    try {
      print('prix');
      print(widget.prix.toString());
      paymentIntentData = await createPaymentIntent(
          widget.prix.toString(), 'EUR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      print("Salut kikouuuu");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'FRA',
                  merchantDisplayName: 'FOODLINE PAIEMENT'))
          .then((value) {});

      ///now finally display payment sheeet
      print("byyye kikouuuu");
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    print("salutt again kikouu");
    Loader.hide();
    print(paymentIntentData!['client_secret']);
    print("bye again kikouu");
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        print("salutt again  again kikouu");
        //    print('payment intent' + paymentIntentData!['id'].toString());
        //  print(
        //         'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['status'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());

        var statutPaiement =
            await getStatutPaiement(paymentIntentData!['id'].toString());
        final status = stripePaymentCommande(
            paymentIntentData!['id'].toString(), statutPaiement.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QrCodeScreen()));
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("payé avec succès")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Annulé"),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      //    print('first prix');
      //print(widget.prix.toString());
      //    print(currency);

      //1   print('yoooooo');
      Map<String, dynamic> body = {
        'amount': calculateAmount(widget.prix.toString()),
        'currency': currency,
        'payment_method_types[]': 'card',
        'customer': 'cus_LAVGRVJfKANZXK',
        'receipt_email': 'touhemib@gmail.com'
      };
      print('yoooooo');
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KDliCIbA1TFqS1mGO7zsozjbmQIZmAVCYf2l1VQP3flyCvJNJOvU9fmnrnGQCo9lAxNSsX1jdc5Qvh7T6sxNQ9b00ijVRFdMI',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
//      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    print('cal');
    print(amount);
    double a = (double.parse(amount)) * 100;
    int price = a.toInt();
    return price.toString();
  }

  Future<bool> stripePaymentCommande(
      String idPaiement, String statutPaiement) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenconst);

    String? idCmd = prefs.getString("idCmd");
    String urlstripePaymentCommande =
        hostDynamique + "api/client/stripePaymentCommande";
    var data = {
      "id_commande": idCmd,
      "id_payment": idPaiement,
      "statut_pay": statutPaiement,
      "mode_paiement": "card"
    };
    final response = await http.post(Uri.parse(urlstripePaymentCommande),
        headers: {'Authorization': 'Bearer $token'}, body: data);

    var body = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 401) {
      Navigator.pushNamed(context, "/login");
      Loader.hide();
      return false;
    } else {
      return false;
    }
  }

  Future<String> getStatutPaiement(String idPaiement) async {
    String statutPaiement = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(tokenconst);
    String? urlstripePaymentCommande = hostDynamique +
        "api/client/get_statut_payment?id_payment=" +
        idPaiement;
    final response = await http.get(
      Uri.parse(urlstripePaymentCommande),
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      //  print('statut paiement=====');
      var body = jsonDecode(response.body);
      //    print(body);
      statutPaiement = body['statut'];
      if (body['statut'] == "succeeded") {
        statutPaiement = "payed";
      } else {
        statutPaiement = "failure";
      }
      return statutPaiement;
    }
    if (response.statusCode == 401) {
      Navigator.pushNamed(context, "/login");
      Loader.hide();
      return "false";
    } else {
      statutPaiement = "failure";
      return statutPaiement;
    }
  }
}
