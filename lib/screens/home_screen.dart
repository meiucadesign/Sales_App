import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sales_app/services/network_helper.dart';
import 'package:searchfield/searchfield.dart';
import '../models/product_model.dart';
import '../styles/styles.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/show_custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController productController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> list = [];

  Map<String, dynamic> productInfo = {
    // "product_id": "4",
    // "product_name": "",
    // "product_rate": 3,
    // "product_quantity": 2,
    // "discount": "100",
    // "total_amount1": "100"
  };

  final _headingRow = const TableRow(
    decoration: BoxDecoration(
      color: Color.fromARGB(179, 31, 154, 236),
    ),
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Product",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Quantity",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Rate",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  double total = 0;
  @override
  void initState() {
    Timer.run(() => showCustomDialog(context)
        .whenComplete(() => NetworkHelper.getProductList()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("add Invoice"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SearchField(
                        controller: productController,
                        validator: ((product) {
                          if (product == null) {
                            return "Enter Product ";
                          } else if (!productList
                              .contains(SearchFieldListItem(product))) {
                            return "Enter Valid Product";
                          } else {
                            return null;
                          }
                        }),
                        onSuggestionTap: (choice) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          rateController.text = productModelList
                              .singleWhere(
                                (element) =>
                                    element.id ==
                                    int.parse(choice.item.toString()),
                              )
                              .rate
                              .toString();
                          productInfo["product_id"] = choice.item;
                          productInfo["product_name"] = choice.searchKey;
                        },
                        suggestions: productList,
                        hint: "Search Product",
                        searchInputDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          border: customNormalTextFieldBorder,
                          errorBorder: customErrorTextFieldBorder,
                          enabledBorder: customNormalTextFieldBorder,
                          focusedBorder: customNormalTextFieldBorder,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: "Nill",
                            child: Text("Nill"),
                          )
                        ],
                        onChanged: null,
                        value: "Nill",
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onSaved: (newValue) {
                                productInfo["product_quantity"] =
                                    int.parse(newValue!);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter quantity";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  fontSize: 13,
                                ),
                                hintText: "Enter Product Quatity",
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
                                label: const Text(
                                  "Quantity",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                                errorBorder: customErrorTextFieldBorder,
                                focusedBorder: customNormalTextFieldBorder,
                                enabledBorder: customNormalTextFieldBorder,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: rateController,
                              onSaved: (newValue) {
                                productInfo["product_rate"] =
                                    int.parse(newValue!);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter rate";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  fontSize: 13,
                                ),
                                hintText: "Enter Rate",
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
                                label: const Text(
                                  "Rate",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                                errorBorder: customErrorTextFieldBorder,
                                focusedBorder: customNormalTextFieldBorder,
                                enabledBorder: customNormalTextFieldBorder,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextFormField(
                              onSaved: (newValue) {
                                productInfo["discount"] = int.parse(newValue!);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter amount";
                                } else if (int.tryParse(value) == null) {
                                  return "invalid Discount";
                                } else if (int.parse(value) > 100) {
                                  return "Discount amount should be less than 100";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.percent,
                                  size: 15,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  fontSize: 13,
                                ),
                                hintText: "Enter Discount",
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
                                label: const Text(
                                  "Dicount",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                                errorBorder: customErrorTextFieldBorder,
                                focusedBorder: customNormalTextFieldBorder,
                                enabledBorder: customNormalTextFieldBorder,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        icon: const Icon(Icons.add_circle),
                        onPressed: () {
                          _addItemtoList();
                        },
                        label: const Text(
                          "Add",
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Table(
                border: TableBorder.all(
                  color: Colors.blue,
                  width: 2,
                ),
                children: [
                  _headingRow,
                  ...list.map((element) {
                    return _productRow(element);
                  }).toList(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                onPressed: (total == 0)
                    ? null
                    : () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Total"),
                                content: Text("The total is $total"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      total = 0;
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Submit"),
                                  ),
                                ],
                              );
                            });
                      },
                child: const Text("Save Invoice"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addItemtoList() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      list.add(productInfo);
      total += productInfo["product_rate"] * productInfo["product_quantity"];
      FocusManager.instance.primaryFocus!.unfocus();
      _formKey.currentState!.reset();
      productController.clear();
      rateController.clear();
    }
  }

  @override
  void dispose() {
    productController.dispose();
    rateController.dispose();
    super.dispose();
  }

  TableRow _productRow(Map<String, dynamic> element) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            element["product_name"],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            element["product_quantity"].toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            element["product_rate"].toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
