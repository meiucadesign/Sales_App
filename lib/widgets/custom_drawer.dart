import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/dashboard.dart';
import '../screens/home_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 250,
      elevation: 4,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        children: [
          Card(
            child: ListTile(
              horizontalTitleGap: 0,
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              subtitle: const Text("Go to Home"),
              selected:
                  ModalRoute.of(context)!.settings.name == HomeScreen.routeName,
              onTap:
                  ModalRoute.of(context)!.settings.name == HomeScreen.routeName
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        },
            ),
          ),
          Card(
            child: ListTile(
              horizontalTitleGap: 0,
              title: const Text("Dashboard"),
              leading: const Icon(Icons.dashboard),
              subtitle: const Text("Go to Dashboard"),
              selected:
                  ModalRoute.of(context)!.settings.name == DashBoard.routeName,
              onTap:
                  ModalRoute.of(context)!.settings.name == DashBoard.routeName
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(DashBoard.routeName);
                        },
            ),
          ),
          const Card(
            child: ListTile(
              horizontalTitleGap: 0,
              title: Text("Invoice"),
              leading: Icon(Icons.receipt),
              subtitle: Text("Add invoice"),
            ),
          ),
          Card(
            child: ListTile(
              horizontalTitleGap: 0,
              title: const Text("Logout"),
              leading: const Icon(Icons.logout_rounded),
              subtitle: const Text("Logout from app"),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Get.offAllNamed(LoginScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
