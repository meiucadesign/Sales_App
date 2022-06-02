import 'package:flutter/material.dart';
import 'package:sales_app/widgets/custom_drawer.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = "/DashBoard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      
    );
  }
}
