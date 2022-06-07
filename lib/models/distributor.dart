import 'package:flutter/cupertino.dart';

class Distributor extends ChangeNotifier {
  String name;
  String number;
  String paymentMethod;
  bool bankSelected;
  // DateTime createdAt;
  String? bankName;

  Distributor({
    required this.name,
    required this.number,
    required this.paymentMethod,
    required this.bankSelected,
    this.bankName,
    // required this.createdAt,
  });
  void selectBank(bool newValue) {
    bankSelected = newValue;
    notifyListeners();
  }

  void updatePaymentMethod(String newPaymentMethod) {
    paymentMethod = newPaymentMethod;
    notifyListeners();
  }
}

Distributor distributor = Distributor(
    name: "", number: "", paymentMethod: "null", bankSelected: false);
