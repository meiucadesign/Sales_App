import 'dart:convert';
import 'package:sales_app/constant/api.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/models/distributor_model.dart';
import 'package:searchfield/searchfield.dart';
import '../models/product_model.dart';

class NetworkHelper {
  static late String branchId;
  static Future logIn({required String email, required String password}) async {
    final response =
        await http.post(Uri.parse("$signInApiKey?email=$email&pass=$password"));
    if (jsonDecode(response.body).length == 0) {
      return false;
    } else {
      var data = jsonDecode(response.body)[0];
      branchId = data["branc_id"];
      return data;
    }
  }

  static getData({required String url}) async {
    final response = await http.get(Uri.parse("$url?branch=$branchId"));
    var data = jsonDecode(response.body);

    if (data["response"]["status"] == "ok") {
      distributorList.clear();
      distributorListItem.clear();
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

  static Future getProductList(String url) async {
    final response = await http.get(Uri.parse("$url?branch=$branchId"));
    var data = jsonDecode(response.body);
    if (data["response"]["status"] == "ok") {
      productList.clear();
      productModelList.clear();
      data["response"]["product_list"].forEach((element) {
        productModelList.add(ProductModel(
            name: element["product_name"],
            id: int.parse(element["id"]),
            branchId: int.parse(element["product_id"]),
            rate: int.parse(element["price"] ?? "0")));
        productList.add(SearchFieldListItem(element["product_name"]));
      });
    }
  }
}
