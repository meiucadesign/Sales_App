import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/models/distributor.dart';
import 'package:sales_app/screens/dashboard.dart';
import 'package:sales_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sales App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginScreen(),
      routes: {
        "/": (context) => SplashScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DashBoard.routeName: (context) => DashBoard(),
      },
    );
  }
}
