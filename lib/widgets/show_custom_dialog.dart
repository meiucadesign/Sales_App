import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/models/currency_model.dart';
import 'package:sales_app/services/insert_invoice.dart';
import 'package:sales_app/services/network_helper.dart';
import 'package:sales_app/screens/dashboard.dart';
import 'package:searchfield/searchfield.dart';
import '../models/distributor_model.dart';

Future<void> showCustomDialog(BuildContext context) async {
  var formKey = GlobalKey<FormState>();
  int selectedCurrency = currencyList.isNotEmpty ? currencyList.first.id : 1;

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        DateTime? selectedDate;
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
                      // Customer Selection FIeld

                      SearchField(
                        suggestions: distributorListItem,
                        onSuggestionTap: (distributorSelected) {
                          InsertInvoice.invoiceInfo["customer_id"] =
                              distributorSelected.item;
                          distributor.name = distributorSelected.searchKey;
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Distributor Name";
                          } else {
                            return null;
                          }
                        },
                        searchInputDecoration: const InputDecoration(
                          hintText: "Distributor Name",
                        ),
                      ),

                      // Payment Method Selection FIeld

                      DropdownButtonFormField<String>(
                        onSaved: (value) {
                          InsertInvoice.invoiceInfo["payment_method"] = value;
                        },
                        validator: (value) {
                          if (value == "null") {
                            return "Select Payment Method";
                          } else {
                            return null;
                          }
                        },
                        value: "null",
                        items: const [
                          DropdownMenuItem(
                            enabled: false,
                            value: "null",
                            child: Text(
                              "Select Payment Method",
                            ),
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

                      // Bank Name Selection FIeld

                      distributor.bankSelected == true
                          ? DropdownButtonFormField(
                              onSaved: (newValue) {
                                InsertInvoice.invoiceInfo["bank_name"] =
                                    newValue;
                              },
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
                      const SizedBox(
                        height: 10,
                      ),

                      // Date Selection FIeld

                      TextButton.icon(
                        onPressed: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(
                              const Duration(
                                days: 30,
                              ),
                            ),
                            lastDate: DateTime.now(),
                          );
                          setState(
                            () {
                              selectedDate = date;
                            },
                          );
                          InsertInvoice.invoiceInfo["date"] =
                              DateFormat("yyyy-MM-dd").format(date!);
                        },
                        icon: const Icon(Icons.date_range),
                        label: Text(
                          selectedDate == null
                              ? "Pick Date"
                              : DateFormat('yyy-MMMM-d').format(selectedDate!),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Currency Selection FIeld

                      DropdownButtonFormField<int>(
                        onSaved: (value) {
                          InsertInvoice.invoiceInfo["currency_id"] = value;
                        },
                        items: currencyList
                            .map(
                              (e) => DropdownMenuItem<int>(
                                value: e.id,
                                child: RichText(
                                  text: TextSpan(
                                    text: e.icon,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " ${e.currencyName}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedCurrency,
                        hint: const Text("Select Currency"),
                        onChanged: (value) {
                          setState(() {
                            selectedCurrency = value ?? 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        DashBoard.routeName, (route) => false);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Next"),
                ),
              ],
            );
          },
        );
      }).then((value) {
    NetworkHelper.getProductList();
  });
}
