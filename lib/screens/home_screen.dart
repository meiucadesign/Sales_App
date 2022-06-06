import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sales_app/models/distributor.dart';
import 'package:sales_app/screens/dashboard.dart';

import '../styles/styles.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Select"), value: "default", enabled: false),
      DropdownMenuItem(child: Text("Panadol"), value: "Panadol"),
      DropdownMenuItem(child: Text("Omnidol"), value: "Omnidol"),
      DropdownMenuItem(child: Text("Dazzy"), value: "Dazzy"),
      DropdownMenuItem(child: Text("ABC1"), value: "ABC"),
    ];
    return menuItems;
  }

  var bankSelected = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Distributor distributor = Distributor(
      name: "", number: "", paymentMethod: "null", bankSelected: false);
  TextEditingController descriptionController = TextEditingController();
  TextEditingController qntController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var productList = [
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
    Timer.run(() => _showDialog());
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
                      DropdownButtonFormField(
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                        validator: (value) {
                          if (value == "default") {
                            return "Select a Product";
                          }
                        },
                        value: firsItem,
                        items: widget.dropdownItems,
                        onChanged: (index) {
                          setState(() {
                            firsItem = index.toString();
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
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
                            child: Text("Nill"),
                            value: "Nill",
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
                          print(
                              "Name:${distributor.name} Number:${distributor.number} Payment Method:${distributor.paymentMethod}");
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
                children: productList,
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
                      TextStyle(fontWeight: FontWeight.normal)),
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
                                        productList.removeRange(
                                            1, productList.length);
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
        productList.add(TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ((widget.dropdownItems
                          .singleWhere((element) => element.value == firsItem))
                      .child as Text)
                  .data!,
              textAlign: TextAlign.center,
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

  _showDialog() {
    var _formKey = GlobalKey<FormState>();

    var selectedValue = "null";
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            title: const Text("Distributor Name"),
            content: SizedBox(
              height: 250,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (newValue) =>
                          distributor.name = newValue.toString(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Distributor Name";
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Distributor Name",
                      ),
                    ),
                    TextFormField(
                      onSaved: (newValue) =>
                          distributor.number = newValue.toString(),
                      validator: (value) =>
                          value!.isEmpty ? "Enter Address" : null,
                      decoration: const InputDecoration(
                        hintText: "Distributor Phone",
                      ),
                    ),
                    DropdownButtonFormField(
                      value: distributor.paymentMethod,
                      items: [
                        DropdownMenuItem(
                          enabled: false,
                          child: Text("Select Payment Method"),
                          value: "null",
                        ),
                        DropdownMenuItem(
                          child: Text("Cash"),
                          value: "Cash",
                        ),
                        DropdownMenuItem(
                          child: Text("Bank"),
                          value: "Bank",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
                        });
                        if (value.toString() == "Bank") {
                          setState(() {
                            widget.bankSelected = true;
                          });
                          print(widget.bankSelected);
                        } else {
                          setState(() {
                            widget.bankSelected = false;
                          });
                        }
                        print(selectedValue);
                      },
                    ),
                    widget.bankSelected
                        ? DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                enabled: false,
                                child: Text("Select Bank"),
                                value: "null",
                              ),
                              DropdownMenuItem(
                                child: Text("HBL"),
                                value: "HBL",
                              ),
                              DropdownMenuItem(
                                child: Text("UBL"),
                                value: "UBL",
                              ),
                              DropdownMenuItem(
                                child: Text("NBP"),
                                value: "NBP",
                              ),
                              DropdownMenuItem(
                                child: Text("ABL"),
                                value: "ABL",
                              ),
                            ],
                            onChanged: (value) {},
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context);
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          );
        });
  }
}
