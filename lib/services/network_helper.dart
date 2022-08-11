import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sales_app/constant/api.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/models/currency_model.dart';
import 'package:sales_app/models/distributor_model.dart';
import 'package:sales_app/services/insert_invoice.dart';
import 'package:searchfield/searchfield.dart';
import '../models/product_model.dart';
import 'package:get/get.dart';

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
      InsertInvoice.invoiceInfo["createby"] = data["userid"];
      return data;
    }
  }

  static getData() async {
    var data;
    try {
      final response =
          await http.get(Uri.parse("$custListApiKey?branch=$branchId"));
      data = jsonDecode(response.body);

      if (data["response"]["status"] == "ok") {
        distributorList.clear();
        distributorListItem.clear();
        data["response"]["customers"].forEach((element) {
          distributorList.add(
            DistributorModel(
              name: element["customer_name"],
              id: int.parse(element["customer_id"]),
              branchId: int.parse(element["branch_id"]),
              bankSelected: false,
            ),
          );

          distributorListItem.add(
            SearchFieldListItem(
              element["customer_name"],
              item: element["customer_id"],
              child: Text(
                element["customer_name"],
              ),
            ),
          );
        });
      }
    } catch (e) {
      if (e.toString().contains("Failed host lookup:")) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("No internet connection"),
          ),
        );
      }
    }
  }

  static Future getProductList() async {
    try {
      final response =
          await http.get(Uri.parse("$productListApiKey?branch=$branchId"));
      var data = jsonDecode(response.body);
      if (data["response"]["status"] == "ok") {
        productList.clear();
        productModelList.clear();
        data["response"]["product_list"].forEach((element) {
          productModelList.add(ProductModel(
              name: element["product_name"],
              id: int.parse(element["product_id"]),
              branchId: int.parse(element["branch_id"]),
              rate: int.parse(element["price"] ?? "0")));
          productList.add(
            SearchFieldListItem(
              element["product_name"],
              item: element["product_id"],
              child: Text(
                element["product_name"],
              ),
            ),
          );
        });
      }
    } catch (e) {
      if (e.toString().contains("Failed host lookup:")) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("No internet connection"),
          ),
        );
      }
    }
  }

  static Future getCurrencyListRequest() async {
    try {
      final response = await http.get(Uri.parse(getCurrencyApiKey));
      var data = jsonDecode(response.body);
      if (data["response"]["status"] == "ok") {
        currencyList = data["response"]["currency"].map((e) {
          return CurrencyModel(
            id: int.parse(e["id"]),
            branchId: int.parse(e["branch_id"]),
            currencyName: e["currency_name"],
            icon: e["icon"],
          );
        }).toList();
      }
    } catch (e) {
      if (e.toString().contains("Failed host lookup:")) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("No internet connection"),
          ),
        );
      }
    }
  }
}
