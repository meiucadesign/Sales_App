import 'package:flutter/material.dart';
import 'package:sales_app/models/distributor.dart';
import 'package:sales_app/screens/dashboard.dart';
import 'package:sales_app/screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginScreen(),
      routes: {
        "/": (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DashBoard.routeName: (context) => DashBoard(),
      },
    );
  }
}
