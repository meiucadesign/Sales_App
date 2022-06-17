import 'package:flutter/material.dart';

import '../models/distributor.dart';

showCustomDialog(BuildContext context) {
  var formKey = GlobalKey<FormState>();

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
                  key: formKey,
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
                        items: const [
                          DropdownMenuItem(
                            enabled: false,
                            value: "null",
                            child: Text("Select Payment Method"),
                          ),
                          DropdownMenuItem(
                            value: "Cash",
                            child: Text("Cash"),
                          ),
                          DropdownMenuItem(
                            value: "Bank",
                            child: Text("Bank"),
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
                          } else {
                            setState(() {
                              distributor.bankSelected = false;
                            });
                          }
                        },
                      ),
                      distributor.bankSelected == true
                          ? DropdownButtonFormField(
                              value: "null",
                              items: const [
                                DropdownMenuItem(
                                  enabled: false,
                                  value: "null",
                                  child: Text("Select Bank"),
                                ),
                                DropdownMenuItem(
                                  value: "HBL",
                                  child: Text("HBL"),
                                ),
                                DropdownMenuItem(
                                  value: "UBL",
                                  child: Text("UBL"),
                                ),
                                DropdownMenuItem(
                                  value: "NBP",
                                  child: Text("NBP"),
                                ),
                                DropdownMenuItem(
                                  value: "ABL",
                                  child: Text("ABL"),
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
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
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
