import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sales_app/models/distributor_model.dart';
import 'package:searchfield/searchfield.dart';
import '../models/product_model.dart';
import '../styles/styles.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/show_custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  var bankSelected = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DistributorModel distributor = DistributorModel(
      name: "", id: 0, branchId: 0, paymentMethod: "null", bankSelected: false);
  TextEditingController productController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController qntController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var productListTable = [
    const TableRow(
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
            "Description",
            overflow: TextOverflow.ellipsis,
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
    )
  ];
  var firsItem = "default";
  double total = 0;
  String msg = "null";
  @override
  void initState() {
    Timer.run(() => showCustomDialog(context));
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
      drawer: const CustomDrawer(),
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
                        suggestions: productList,
                        hint: "Search Product",
                        searchInputDecoration: InputDecoration(
                          border: customNormalTextFieldBorder,
                          errorBorder: customErrorTextFieldBorder,
                          enabledBorder: customNormalTextFieldBorder,
                          focusedBorder: customNormalTextFieldBorder,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(12),
                        height: 5 * 24.0,
                        child: TextFormField(
                          controller: descriptionController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            hintText: "Enter Product Description",
                            hintStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
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
                        onChanged: (index) {},
                        value: "Nill",
                      ),
                      TextFormField(
                        controller: qntController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter rate";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          hintText: "Enter Product Quatity",
                          hintStyle: const TextStyle(color: Colors.black38),
                          label: const Text(
                            "Quantity",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          errorBorder: customErrorTextFieldBorder,
                          focusedBorder: customNormalTextFieldBorder,
                          enabledBorder: customNormalTextFieldBorder,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter discount amount";
                          } else if (int.tryParse(value) == null) {
                            return "Enter valid discount amount";
                          } else if (int.parse(value) > 100) {
                            return "Discount amount should be less than 100";
                          } else {
                            return null;
                          }
                        },
                        controller: discountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          hintText: "Enter Discount",
                          hintStyle: const TextStyle(color: Colors.black38),
                          label: const Text(
                            "Dicount",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          errorBorder: customErrorTextFieldBorder,
                          focusedBorder: customNormalTextFieldBorder,
                          enabledBorder: customNormalTextFieldBorder,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter rate";
                          } else {
                            return null;
                          }
                        },
                        controller: rateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          hintText: "Enter Rate",
                          hintStyle: const TextStyle(color: Colors.black38),
                          label: const Text(
                            "Rate",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          errorBorder: customErrorTextFieldBorder,
                          focusedBorder: customNormalTextFieldBorder,
                          enabledBorder: customNormalTextFieldBorder,
                        ),
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
                children: productListTable,
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
                                      setState(() {
                                        productListTable.removeRange(
                                            1, productListTable.length);
                                      });
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
      setState(() {
        productListTable.add(TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                productController.text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                descriptionController.text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              qntController.text,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              rateController.text,
              textAlign: TextAlign.center,
            ),
          ),
        ]));
      });
      total = total +
          int.parse(rateController.text) * int.parse(qntController.text);
      _formKey.currentState!.reset();
    }
  }
}
