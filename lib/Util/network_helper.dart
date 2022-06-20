import 'dart:convert';

import 'package:sales_app/constant/api.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/models/distributor_model.dart';
import 'package:searchfield/searchfield.dart';

import '../models/product_model.dart';

class NetworkHelper {
  static Future logIn({required String email, required String password}) async {
    final response =
        await http.post(Uri.parse("$signInApiKey?email=$email&pass=$password"));
    if (jsonDecode(response.body).length == 0) {
      return false;
    } else {
      return jsonDecode(response.body)[0];
    }
  }

  static getData({required String url}) async {
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    if (data["response"]["status"] == "ok") {
      data["response"]["customers"].forEach((element) {
        distributorList.add(
          DistributorModel(
            name: element["customer_name"],
            id: int.parse(element["customer_id"]),
            branchId: int.parse(element["branch_id"]),
            paymentMethod: "",
            bankSelected: false,
          ),
        );
        distributorListItem.add(SearchFieldListItem(element["customer_name"]));
      });
    }
  }

  static getProductList(String url) async {
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    if (data["response"]["status"] == "ok") {
      data["response"]["product_list"].forEach((element) {
        productList.add(
            //   Distributor(
            //   name: element["customer_name"],
            //   id: int.parse(element["customer_id"]),
            //   branchId: int.parse(element["branch_id"]),
            //   paymentMethod: "",
            //   bankSelected: false,
            // )
            SearchFieldListItem(element["product_name"]));
      });
    }
  }
}
