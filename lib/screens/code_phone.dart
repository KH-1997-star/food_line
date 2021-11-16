import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/widgets/count_down_timer.dart';
import 'package:food_line/widgets/my_app_bar_widget.dart';
import 'package:food_line/widgets/phone_code_row.dart';
import 'package:food_line/widgets/suivant_button.dart';

class CodePhone extends StatefulWidget {
  @override
  _CodePhoneState createState() => _CodePhoneState();
}

class _CodePhoneState extends State<CodePhone> {
  double oneMinute = 60;
  final formKey = GlobalKey<FormState>();

  List myVerifNumber = [];

  @override
  Widget build(BuildContext context) {
    myVerifNumber.length = 4;
    Map data = {};

    data = ModalRoute.of(context).settings.arguments;
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBarWidget(
              myLeftPadding: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26, top: 40),
              child: Container(
                child: Text(
                  'Saisissez le code à 4 chiffres envoyé\nau ${data['phoneCode']} ${data['phoneNumber']}',
                  style: bold,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            //le code de cette widget ce trouve dans le fichier phone_code_row.dart
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Form(
                key: formKey,
                child: PhoneCodeRow(
                  onFirstContainer: (String val) => myVerifNumber[0] = val,
                  onSecondContainer: (String val) => myVerifNumber[1] = val,
                  onThirdContainer: (String val) => myVerifNumber[2] = val,
                  onFourthContainer: (String val) => myVerifNumber[3] = val,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //le code de cette widget ce trouve dans le fichier count_down_timer.dart
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: CountDownTimer(),
            ),
          ],
        ),
        persistentFooterButtons: [
          //le code de cette widget ce trouve dans le fichier suivant_button.dart
          SuivantButton(
            onSuivantPressed: () {
              if (formKey.currentState.validate()) {
                Navigator.pushNamed(context, '/mail_verif');
              }
            },
          ),
        ],
      ),
    );
  }
}
