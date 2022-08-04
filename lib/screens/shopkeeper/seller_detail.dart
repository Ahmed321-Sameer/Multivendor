import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/searching.dart';
import 'package:multivendor/screens/shopkeeper/seller_home.dart';

class Seller_Detail extends StatefulWidget {
  @override
  State<Seller_Detail> createState() => _Seller_DetailState();
}

class _Seller_DetailState extends State<Seller_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  Object? _itemValue;
  var listItem = [
    'Grosery',
    'Grament',
    'hardware',
    'Software',
  ];
  String store_type = "";
  int? _radioValue = 0;

  // void _handleRadioValueChange(int? value) {
  //   setState(() {
  //     _radioValue = value;

  //     switch (_radioValue) {
  //       case 0:
  //         break;
  //       case 1:
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Seller Detail',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Business Name',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 9),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 15, right: 11, top: 4, bottom: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(3),
                // color: Colors.white
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text(
                  'Store Type',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                icon: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Search_type()));
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
                value: _itemValue,
                onChanged: (value) {
                  setState(() {
                    store_type = value.toString();
                    _itemValue = value;
                  });
                },
                items: listItem.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: addressController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Store Address',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: cityController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your City',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  )),
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // const Padding(
          //   padding: EdgeInsets.only(
          //     left: 8,
          //   ),
          //   child: Text(
          //     'Do you have a physical store?',
          //     style: TextStyle(
          //         color: Colors.blue,
          //         fontWeight: FontWeight.w500,
          //         fontSize: 16),
          //   ),
          // ),
          // Row(
          //   children: [
          //     Theme(
          //       data: Theme.of(context)
          //           .copyWith(unselectedWidgetColor: Colors.white),
          //       child: Radio(
          //         activeColor: Color(0xff0db14c),
          //         value: 0,
          //         groupValue: _radioValue,
          //         onChanged: _handleRadioValueChange,
          //       ),
          //     ),
          //     const Text(
          //       'Yes',
          //       style: TextStyle(fontSize: 16.0),
          //     ),
          //     Theme(
          //       data: Theme.of(context)
          //           .copyWith(unselectedWidgetColor: Colors.black),
          //       child: Radio(
          //         activeColor: Color(0xff0db14c),
          //         value: 1,
          //         groupValue: _radioValue,
          //         onChanged: _handleRadioValueChange,
          //       ),
          //     ),
          //     const Text(
          //       'No',
          //       style: TextStyle(
          //         fontSize: 16.0,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("user")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    // "name": nameController.text.trim(),
                    // "email": emailController.text.trim(),
                    // "id": value.user!.uid,
                    "busines-name": nameController.text.trim(),
                    "store_type": store_type,
                    "address": addressController.text.trim(),
                    "city": cityController.text.trim(),
                  });
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Seller_Home()));
                },
              )),
        ],
      ),
    );
  }
}
