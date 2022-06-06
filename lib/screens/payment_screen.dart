import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:food_line/screens/comming_soon.dart';
import 'package:food_line/screens/qr_code_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/livreur_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/payment_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  final String? prix;
  const PaymentScreen({Key? key, this.prix}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int itemLength = 5;
  List<bool> myList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 2; i += 1) {
      myList.add(false);
    }
    print(myList);
  }

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 36.h,
                        horizontal: 36.w,
                      ),
                      child: Row(
                        children: [
                          // MyWidgetButton(
                          //   widget: myBackIcon,
                          //   onTap: () => Navigator.pop(context),
                          // ),
                          // SizedBox(
                          //   width: 40.w,
                          // ),
                          Text(
                            'Moyens de paiement',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: my_green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: PaymentWidget(
                        isTaped: myList[0],
                        taped: () => setState(() {
                          print(myList[0]);
                          myList = unClick(0, 2);
                        }),
                        cartePath: 'icons/masterCard.svg',
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 36.w),
                    //   child: PaymentWidget(
                    //     isTaped: myList[1],
                    //     taped: () => setState(() {
                    //       print(myList[1]);
                    //       myList = unClick(1, 2);
                    //     }),
                    //     cartePath: 'icons/paypal.png',
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 12.h,
                    // ),
                    Row(
                      children: [
                        SizedBox(
                          width: 36.w,
                        ),
                        MyWidgetButton(
                          color: const Color(0xFFF0F0F0),
                          widget: const Center(
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Ajouter une nouvelle carte',
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 36.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MyWidgetButton(
                      widget: CommanderWidget(
                        title: "Payer",
                        titleLeftPadding: 41,
                        priceLeftPadding: 24,
                        myPrice: '${widget.prix}',
                      ),
                      /* onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      child: ComingSoonScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                    ),
                  ),*/
                      onTap: () async {
                        await makePayment();
                      },
                      color: my_black,
                      width: 303,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    Loader.hide();
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
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
        //     print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
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

    return true;
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
    } else {
      statutPaiement = "failure";
      return statutPaiement;
    }
  }
}
