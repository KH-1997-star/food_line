import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/my_app_bar_widget.dart';
import 'package:food_line/widgets/suivant_button.dart';

class CodeMailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String code = '';
    Map data = {};
    data = ModalRoute.of(context).settings.arguments;
    String email = data['email'];
    email = shiftEmail(email);

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
                'S\'aisissez le code à 4 chiffres envoyé\nau:\n $email',
                style: bold,
              ),
              SizedBox(
                height: myPhoneHeight(context) / 13,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 190,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) => code = val,
                      maxLength: 4,
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: Color(0xffeeeeee),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffeeeeee),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 190,
                    height: 40,
                    color: Color(0xffeeeeee),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/mail_verif');
                        },
                        child: Text(
                          'Ce n\'est pas mon compte',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: myPhoneHeight(context) / 35,
              ),
              Row(
                children: [
                  Container(
                    width: 92,
                    height: 40,
                    color: Color(0xffeeeeee),
                    child: TextButton(
                        onPressed: () {
                          print(code);
                          //TODO right function here
                        },
                        child: Text(
                          'Renvoyer',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          SuivantButton(
            onSuivantPressed: () =>
                Navigator.pushNamed(context, '/etapes_screen'),
          ),
        ],
      ),
    );
  }
}
