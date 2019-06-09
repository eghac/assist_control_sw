import 'package:assist_control_all_sw/src/pages/service_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      marked: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assist Control App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: 'home',
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          ServiceDetailPage.routeName: (BuildContext context) => ServiceDetailPage(),
        },
      ),
    );
  }
}
