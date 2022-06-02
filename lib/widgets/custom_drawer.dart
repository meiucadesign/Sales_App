import 'package:flutter/material.dart';
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
              title: Text("Home"),
              leading: Icon(Icons.home),
              subtitle: Text("Go to Home"),
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
              title: Text("Dashboard"),
              leading: Icon(Icons.dashboard),
              subtitle: Text("Go to Dashboard"),
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
          Card(
            child: ListTile(
              horizontalTitleGap: 0,
              title: Text("Invoice"),
              leading: Icon(Icons.receipt),
              subtitle: Text("Add invoice"),
            ),
          ),
        ],
      ),
    );
  }
}
