import 'package:searchfield/searchfield.dart';

class DistributorModel {
  String name;
  int id;
  int branchId;
  String paymentMethod;
  bool bankSelected;
  // DateTime createdAt;
  String? bankName;

  DistributorModel({
    required this.name,
    required this.id,
    required this.branchId,
    required this.paymentMethod,
    required this.bankSelected,
    this.bankName,
    // required this.createdAt,
  });
  void selectBank(bool newValue) {
    bankSelected = newValue;
  }

  void updatePaymentMethod(String newPaymentMethod) {
    paymentMethod = newPaymentMethod;
  }
}

List<DistributorModel> distributorList = [];
List<SearchFieldListItem> distributorListItem = [];
