import 'package:flutter/material.dart';

import '../styles/styles.dart';

class HomeScreen extends StatefulWidget {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Select"), value: "default", enabled: false),
      DropdownMenuItem(child: Text("Panadol"), value: "Panadol"),
      DropdownMenuItem(child: Text("Omnidol"), value: "Omnidol"),
      DropdownMenuItem(child: Text("Dazzy"), value: "Dazzy"),
      DropdownMenuItem(child: Text("ABC1"), value: "ABC"),
    ];
    return menuItems;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController qntController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var productList = [
    const TableRow(
      children: [
        Text(
          "Product",textAlign: TextAlign.center,),
        Text("Description",textAlign: TextAlign.center,),
        Text("Quantity",textAlign: TextAlign.center,),
        Text("Rate",textAlign: TextAlign.center,),
      ],
    )
  ];
  var firsItem = "default";
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("add Invoice"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
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
                            hintText: "Enter Product Description",
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
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
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: customTextFieldDecoration,
                          enabledBorder: customTextFieldDecoration,
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
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: customTextFieldDecoration,
                          enabledBorder: customTextFieldDecoration,
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
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: customTextFieldDecoration,
                          enabledBorder: customTextFieldDecoration,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          _addItemtoList();
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Table(
                border: TableBorder.all(
                  color: Colors.white,
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
                  foregroundColor: MaterialStateProperty.all(Colors.white,),
                  textStyle: MaterialStateProperty.all(TextStyle(fontWeight: FontWeight.normal)),
                ),
                onPressed: (total==0)?null:() {
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
                            ),TextButton(
                              onPressed: () {
                                setState(() {
                                  
                                productList.removeRange(1, productList.length);
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
          Text(((widget.dropdownItems
                      .singleWhere((element) => element.value == firsItem))
                  .child as Text)
              .data!),
          Center(
            child: Text(descriptionController.text,
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Text(qntController.text),
          Text(rateController.text),
        ]));
      });
      total = total +
          int.parse(rateController.text) * int.parse(qntController.text);
      _formKey.currentState!.reset();
    }
  }
}
