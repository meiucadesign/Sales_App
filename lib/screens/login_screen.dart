import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/Util/network_helper.dart';
import 'package:sales_app/screens/home_screen.dart';
import 'package:sales_app/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales App"),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
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
                      offset: Offset(2, 5),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, -5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Form(
                  key: _formKey,
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
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          } else if (!value.contains("@")) {
                            return "Enter Valid Email";
                          }
                        },
                        controller: emailController,
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
                          focusedBorder: customNormalTextFieldBorder,
                          enabledBorder: customNormalTextFieldBorder,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                        },
                        controller: passwordController,
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
                          focusedBorder: customNormalTextFieldBorder,
                          enabledBorder: customNormalTextFieldBorder,
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
                          minimumSize: MaterialStateProperty.all(
                            Size(150, 40),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            _submitForm();
                          }
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
      ),
    );
  }

  void _submitForm() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginResponse = await NetworkHelper.logIn(
        email: emailController.text, password: passwordController.text);
    if (loginResponse == false) {
      Fluttertoast.showToast(
        msg: "invalid email or password",
        toastLength: Toast.LENGTH_SHORT,
      );
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      prefs
          .setBool("isLoggedIn", true)
          .then((value) => print("logged in successfully"));
      Get.to(HomeScreen());
    }
  }
}
