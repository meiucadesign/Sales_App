import 'package:flutter/material.dart';
import 'package:sales_app/screens/home_screen.dart';
import 'package:sales_app/styles/styles.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales App"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          height: screenSize.height * .40,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 236, 236, 236),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(221, 27, 27, 27),
                offset: Offset(5, 5),
                blurRadius: 10,
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  floatingLabelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                  label: const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.black38,
                  ),
                  focusedBorder: customTextFieldDecoration,
                  enabledBorder: customTextFieldDecoration,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  floatingLabelStyle: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                  hintText: "Enter Password",
                  hintStyle: const TextStyle(color: Colors.black38),
                  label: const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  focusedBorder: customTextFieldDecoration,
                  enabledBorder: customTextFieldDecoration,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.login_rounded,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                    minimumSize: MaterialStateProperty.all(Size(150, 40))),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      ((route) => false));
                },
                label: const Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
