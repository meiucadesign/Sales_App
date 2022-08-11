import 'package:searchfield/searchfield.dart';

class DistributorModel {
  String name;
  int id;
  int branchId;
  bool bankSelected;
  String? bankName;

  DistributorModel({
    required this.name,
    required this.id,
    required this.branchId,
    required this.bankSelected,
    this.bankName,
    // required this.createdAt,
  });
  void selectBank(bool newValue) {
    bankSelected = newValue;
  }
}

List<DistributorModel> distributorList = [];
List<SearchFieldListItem> distributorListItem = [];
DistributorModel distributor = DistributorModel(
  name: "",
  id: 0,
  branchId: 0,
  bankSelected: false,
);
