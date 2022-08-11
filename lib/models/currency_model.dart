class CurrencyModel {
  int id;
  int branchId;
  String currencyName;
  String icon;

  CurrencyModel({
    required this.id,
    required this.branchId,
    required this.currencyName,
    required this.icon,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        branchId: json["branch_id"],
        currencyName: json["currency_name"],
        icon: json["icon"],
        id: json["id"],
      );
}

List currencyList = [];
