import 'package:flutter/material.dart';
import 'package:food_line/screens/code_mail_screen.dart';
import 'package:food_line/screens/code_phone.dart';
import 'package:food_line/screens/costom_article_screen.dart';
import 'package:food_line/screens/etapes_screen.dart';
import 'package:food_line/screens/mail_verif_screen.dart';
import 'package:food_line/screens/menu_screen.dart';
import 'package:food_line/screens/plus_screen.dart';
import 'package:food_line/screens/resto_screen.dart';
import 'package:food_line/screens/the_searching_screen.dart';
import 'package:food_line/screens/time_choose_screen.dart';
import 'package:food_line/utils/my_theme_data.dart';

import 'screens/loading_screen.dart';
import 'screens/phone_verif_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: myThemeData,
      initialRoute: '/resto_screen',
      routes: {
        '/': (context) => LoadingScreen(),
        '/phone_verif': (context) => PhoneVerifScreen(),
        '/phone_code': (context) => CodePhone(),
        '/mail_verif': (context) => MailVerifScreen(),
        '/code_mail': (context) => CodeMailScreen(),
        '/etapes_screen': (context) => EtapesScreen(),
        '/time_choose_screen': (context) => TimeChooseScreen(),
        '/resto_screen': (context) => RestoScreen(),
        '/plus_screen': (context) => PlusScreen(),
        '/the_searching_screen': (context) => TheSearchingScreen(),
        '/menu_screen': (context) => MenuScreen(),
        '/costum_article_screen': (context) => CostumArticleScreen(),
      },
    );
  }
}
