import 'package:searchfield/searchfield.dart';

class ProductModel {
  String name;
  int id;
  int branchId;
  int rate;
  // String paymentMethod;
  // bool bankSelected;
  // DateTime createdAt;
  // String? bankName;

  ProductModel({
    required this.name,
    required this.id,
    required this.branchId,
    required this.rate,
    // required this.paymentMethod,
    // required this.bankSelected,
    // this.bankName,
    // required this.createdAt,
  });
//   void selectBank(bool newValue) {
//     bankSelected = newValue;
//   }

//   void updatePaymentMethod(String newPaymentMethod) {
//     paymentMethod = newPaymentMethod;
//   }
}

List<ProductModel> productModelList = [];
List<SearchFieldListItem> productList = [];
