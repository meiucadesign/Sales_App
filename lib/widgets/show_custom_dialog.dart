import 'package:flutter/material.dart';

import '../models/distributor.dart';

showCustomDialog(BuildContext context) {
  var _formKey = GlobalKey<FormState>();

  var selectedValue = "null";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: const Text("Distributor Name"),
              content: SizedBox(
                height: 300,
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
                        validator: (value) {
                          if (value == "null") {
                            return "Select Payment Method";
                          }
                        },
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
                              distributor.bankSelected = true;
                            });
                            print(distributor.bankSelected);
                          } else {
                            setState(() {
                              distributor.bankSelected = false;
                            });
                          }
                          print(selectedValue);
                        },
                      ),
                      distributor.bankSelected == true
                          ? DropdownButtonFormField(
                              value: "null",
                              items: const [
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
                              onChanged: (value) {
                                distributor.bankName = value.toString();
                              },
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
          },
        );
      });
}
