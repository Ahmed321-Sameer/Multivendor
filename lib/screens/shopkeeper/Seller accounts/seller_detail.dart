import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/Home/Seller_nav.dart';
import 'package:multivendor/screens/shopkeeper/Seller%20accounts/searching.dart';
import 'package:multivendor/screens/shopkeeper/Home/seller_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController numberController = TextEditingController();

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
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formkey,
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
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Business Name',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, right: 9),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 11, top: 4, bottom: 4),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Search_type()));
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
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
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
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: cityController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Your City',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (val) {
                  if (val!.length < 11) {
                    return "complete number";
                  } else {
                    return null;
                  }
                },
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Phone number',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Continue'),
                onPressed: () async {
                  SharedPreferences prefs = await _prefs;
                  if (formkey.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection("seller")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      // "name": nameController.text.trim(),
                      // "email": emailController.text.trim(),
                      // "id": value.user!.uid,
                      "busines-name": nameController.text.trim(),
                      "number": numberController.text.trim(),
                      "store_type": store_type,
                      "address": addressController.text.trim(),
                      "city": cityController.text.trim(),
                      "status": "waiting",
                    });
                    prefs.setString("bussines", nameController.text);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SellerNavBar()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
