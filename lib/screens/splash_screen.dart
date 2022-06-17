import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/screens/home_screen.dart';
import 'package:sales_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  bool isLoggedIn = false;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getLogInData().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
        Get.off(widget.isLoggedIn ? HomeScreen() : LoginScreen());
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            const SizedBox(height: 20),
            const SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }

  Future getLogInData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }
}
