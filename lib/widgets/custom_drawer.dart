import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/screens/login_screen.dart';
import 'package:sales_app/services/network_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/dashboard.dart';
import '../screens/home_screen.dart';

class CustomDrawer extends StatelessWidget {
  String email = "A";
  void loadEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString("email")!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: email,
      future: Future(
        () {
          loadEmail();
        },
      ),
      builder: ((context, snapshot) {
        return Drawer(
          backgroundColor: Colors.white,
          width: 250,
          elevation: 4,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            children: [
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 5),
                    horizontalTitleGap: 10,
                    leading: CircleAvatar(
                      child: Text(
                        email.split("@")[0][0].toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      "Name:${email.split("@")[0]}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "Email:$email",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  horizontalTitleGap: 0,
                  title: const Text("Home"),
                  leading: const Icon(Icons.home),
                  subtitle: const Text("Go to Home"),
                  selected: Get.currentRoute == HomeScreen.routeName,
                  onTap: Get.currentRoute == HomeScreen.routeName
                      ? null
                      : () {
                          NetworkHelper.getData();
                          NetworkHelper.getCurrencyListRequest();
                          Get.offNamed(HomeScreen.routeName);
                        },
                ),
              ),
              Card(
                child: ListTile(
                  horizontalTitleGap: 0,
                  title: const Text("Dashboard"),
                  leading: const Icon(Icons.dashboard),
                  subtitle: const Text("Go to Dashboard"),
                  selected: Get.currentRoute == DashBoard.routeName,
                  onTap: Get.currentRoute == DashBoard.routeName
                      ? null
                      : () {
                          Get.offNamed(DashBoard.routeName);
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear().whenComplete(
                        () => Get.offAllNamed(LoginScreen.routeName));
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
