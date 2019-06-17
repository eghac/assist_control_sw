import 'package:assist_control_all_sw/src/pages/profile_page.dart';
import 'package:assist_control_all_sw/src/pages/service_detail_page.dart';
import 'package:assist_control_all_sw/src/pages/signin_page.dart';
import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/pages/home_page.dart';
import 'package:assist_control_all_sw/src/pages/signup_page.dart';

void main() async {
  final _prefs = new PreferenciasUsuario();
  await _prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    _prefs.initPrefs();

    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
    });

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    return Provider(
      marked: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assist Control App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute:
            _prefs.email == '' ? LoginPage.routeName : HomePage.routeName,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          ServiceDetailPage.routeName: (BuildContext context) =>
              ServiceDetailPage(),
          SignupPage.routeName: (BuildContext context) => SignupPage(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          ProfilePage.routeName: (BuildContext context) => ProfilePage(),
        },
      ),
    );
  }
}
