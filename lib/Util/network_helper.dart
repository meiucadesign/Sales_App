import 'dart:convert';

import 'package:sales_app/constant/api.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future logIn({required String email, required String password}) async {
    final response =
        await http.post(Uri.parse("$apiKey?email=$email&pass=$password"));
    if (jsonDecode(response.body).length == 0) {
      return false;
    } else {
      return jsonDecode(response.body)[0];
    }
  }
}
