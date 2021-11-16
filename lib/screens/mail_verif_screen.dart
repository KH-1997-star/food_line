import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/widgets/my_app_bar_widget.dart';
import 'package:food_line/widgets/suivant_button.dart';

class MailVerifScreen extends StatefulWidget {
  @override
  _MailVerifScreenState createState() => _MailVerifScreenState();
}

class _MailVerifScreenState extends State<MailVerifScreen> {
  String email = '';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBarWidget(
                myLeftPadding: 0,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Quelle est votre adresse e-mail ?',
                style: bold,
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 263,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) => email = val,
                    validator: (val) =>
                        val.isEmpty ? 'ce champ ne peut pas etre vide' : null,
                    decoration: InputDecoration(
                      fillColor: Color(0xffeeeeee),
                      hintText: 'Nom@gmail.com',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xff9C9C9C),
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          //le code de cette widget ce trouve dans le fichier suivant_button.dart
          SuivantButton(
            onSuivantPressed: () {
              if (formKey.currentState.validate()) {
                Navigator.pushNamed(
                  context,
                  '/code_mail',
                  arguments: {
                    'email': email,
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
