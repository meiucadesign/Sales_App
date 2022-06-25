import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/screens/dashboard.dart';
import 'package:sales_app/screens/home_screen.dart';
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
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(name: DashBoard.routeName, page: () => DashBoard()),
        GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
      ],
    );
  }
}
