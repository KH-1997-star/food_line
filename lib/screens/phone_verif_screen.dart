import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/widgets/my_app_bar_widget.dart';
import 'package:food_line/widgets/suivant_button.dart';

class PhoneVerifScreen extends StatefulWidget {
  @override
  _PhoneVerifScreenState createState() => _PhoneVerifScreenState();
}

class _PhoneVerifScreenState extends State<PhoneVerifScreen> {
  final formKey = GlobalKey<FormState>();
  String phoneNumber;

  List listItem = [
    '+33',
    '+216',
    '+41',
    '+213',
  ];
  String phoneCode = '+216';

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyAppBarWidget(
                  myLeftPadding: 0,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Saisissez votre numero de téléphone portable',
                  style: bold,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            color: Color(0xffEEEEEE),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                validator: (value) => value.isEmpty
                                    ? 'ce champ est obligatoire'
                                    : null,
                                icon: Icon(
                                  Icons.expand_more,
                                  size: 15,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: myBorderSide,
                                  ),
                                ),
                                dropdownColor: Color(0xffEEEEEE),
                                iconDisabledColor: Colors.black,
                                iconEnabledColor: Colors.black,
                                isExpanded: true,
                                value: phoneCode,
                                onChanged: (value) {
                                  setState(() {
                                    phoneCode = value;
                                  });
                                },
                                items: listItem.map((valueItem) {
                                  return DropdownMenuItem(
                                    child: Text(valueItem),
                                    value: valueItem,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 100,
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              phoneNumber = val;
                            });
                          },
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? 'ce champ est obligatoire' : null,
                          decoration: InputDecoration(
                            fillColor: Color(0xffeeeeee),
                            filled: true,
                            hintText: '      Numéro de téléphone',
                            hintStyle: TextStyle(
                              color: Color(0xff9C9C9C),
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 15,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: myBorderSide,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          //le code de cette widget ce trouve dans le fichier suivant_button.dart
          SuivantButton(
            onSuivantPressed: () {
              if (formKey.currentState.validate()) {
                Navigator.pushNamed(
                  context,
                  '/phone_code',
                  arguments: {
                    'phoneCode': phoneCode,
                    'phoneNumber': phoneNumber,
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
