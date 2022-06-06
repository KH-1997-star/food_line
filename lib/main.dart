// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/src/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_line/screens/DetailsCategorie/detail_category_screen.dart';
import 'package:food_line/screens/GererProfil/gerer_profil_screen.dart';
import 'package:food_line/screens/ListeMenu/test.dart';
import 'package:food_line/screens/DetailsPlat/detail_plat.dart';
import 'package:food_line/screens/DetailsPlat/list_radio.dart';
import 'package:food_line/screens/LocationLivreur/livreur_location_map.dart';
import 'package:food_line/screens/LocationLivreur/location_screen.dart';
import 'package:food_line/screens/Mes%20commandes/mes_commandes_screen.dart';
import 'package:food_line/screens/Mes%20commandes/suivi_commande_screen.dart';
import 'package:food_line/screens/Panier/liste_station_screen.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/Panier/recap.dart';
import 'package:food_line/screens/comming_soon.dart';
import 'package:food_line/screens/detect_livreur_screen.dart';
import 'package:food_line/screens/forgetPwd/forget_pwd_one.dart';
import 'package:food_line/screens/forgetPwd/forget_pwd_three.dart';
import 'package:food_line/screens/forgetPwd/forget_pwd_two.dart';

import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/screens/landingScreen.dart/landing_screen.dart';
import 'package:food_line/screens/landingScreen.dart/landingscreen1.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/login/activate_account.dart';
import 'package:food_line/screens/lieu_screen.dart';
import 'package:food_line/screens/login/signup_screen.dart';
import 'package:food_line/screens/login/login_screen.dart';
import 'package:food_line/screens/location_screen.dart';
import 'package:food_line/screens/menuPage/menu_screen.dart';
import 'package:food_line/screens/notification.dart';
import 'package:food_line/screens/Panier/panier_screen.dart';
import 'package:food_line/screens/payment_screen.dart';
import 'package:food_line/screens/qr_code_screen.dart';
import 'package:food_line/screens/slide_screen.dart';
import 'package:food_line/screens/testforlder/notification_screen_test.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'screens/a_propos_screen.dart';
import 'screens/favoris_screen.dart';
import 'screens/list_livreur_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _messageHandler(RemoteMessage message) async {}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.getToken();
  Stripe.publishableKey =
      "pk_test_51KDliCIbA1TFqS1mt2weYi9te52QyslfuYSQjNmcK7zt9CsSal43a7wC2PJvwa4o50twjb25yMQv6cMI1lCdh6g0000sJmFxoJ";
  //Stripe.merchantIdentifier = 'any string works';

  await Stripe.instance.applySettings();
  //hello

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      ProviderScope(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<PanierNotifier>(
                create: (_) => PanierNotifier()),
            ChangeNotifierProvider(
              create: (BuildContext context) {},
            )
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;
  List subscribed = [];
  List topics = [
    'Samsung',
    'Apple',
    'Huawei',
    'Nokia',
    'Sony',
    'HTC',
    'Lenovo'
  ];
  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
              iOS: const IOSNotificationDetails(),
            ));
      }
    });
    getToken();
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = false;
    return OverlaySupport(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xffffffff),
            fontFamily: 'Roboto',
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const LandingScreenOne(),
            '/login': (context) => const LoginScreen(),
            '/inscription': (context) => const SignUpScreen(),
            '/slide_screen': (context) => const SlideScreen(),
            '/location_screen': (context) => const LocationScreen(),
            '/landingScreen': (context) => const LandingScreen(),
            '/activateAccount': (context) => const ActivateAccountScreen(),
            "/landingScreenOne": (context) => const LandingScreenOne(),
            '/forgetPwdOne': (context) => const ForgetPwdOneScreen(),
            '/forgetPwdTwo': (context) => const ForgetPwdTwoScreen(),
            '/forgetPwdThree': (context) => const ForgetPwdThreeScreen(),
            '/detailsPlat': (context) => const DetailsPlatScreen(),
            '/GroupedButton': (context) => Affiche_grille(),
            '/home_screen': (context) => const HomeScreen(),
            'C': (context) => const PanierScreen(),
            '/panier_screen': (context) => const PanierScreen(),
            '/menu_screen': (context) => MenuScreen(),
            '/detailCategory': (context) => DetailCategortScreen(),
            '/mesCommandes': (context) => MesCommandeScreen(),
            '/test': (context) => MyHomePage1(),
            '/suiviCmd': (context) => SuiviCommandeScreen(),
            '/notifcation_screen': (context) => const NotificationScreen(),
            '/lieu_screen': (context) => const LieuScreen(),
            '/favoris_screen': (context) => const FavorisScreen(),
            '/a_propos_screen': (context) => const AProposScreen(),
            '/location_command_screen': (context) => LocationCommand(),
            '/livreur_list_screen': (context) => const ListLivreurScreen(),
            '/payment_screen': (context) => const PaymentScreen(),
            '/qr_code_screen': (context) => const QrCodeScreen(),
            '/profil': (context) => ProfilScreen(),
            '/stations': (context) => StationsScreen(),
            '/comingSoon': (context) => ComingSoonScreen(),
            '/locationLivreur': (context) => LocationLivreurScreen(),
            '/locationScreen': (context) => LocationMenuScreen(),
            '/testNotif': (context) => HomePage(),
            '/detect_livreur_pos_screen': (context) =>
                const DetectLivreurScreen(),
            '/recap': (context) => RecapScreen(),
          },
        ),
      ),
    );
  }
}
