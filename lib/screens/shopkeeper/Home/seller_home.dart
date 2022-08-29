import 'dart:async';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multivendor/screens/shopkeeper/Orders/View_Orders.dart';
import 'package:multivendor/screens/shopkeeper/hisaaab/create_bills.dart';
import 'package:multivendor/screens/shopkeeper/hisaaab/hisab.dart';
import 'package:multivendor/screens/shopkeeper/Products/Upload_product.dart';
import 'package:multivendor/screens/shopkeeper/Home/Seller_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../onboard.dart';

class Seller_Home extends StatefulWidget {
  Seller_Home({Key? key}) : super(key: key);

  @override
  State<Seller_Home> createState() => _Seller_HomeState();
}

class _Seller_HomeState extends State<Seller_Home> {
  final GlobalKey _scaffoldKey = GlobalKey();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String business_name = "loading";
  String check = "success";
  String number = "loading";

  int order = 0;
  bool checkisexsist = false;
  bool status = false;
  String owner_name = "loading";
  String seller_phone = "loading";
  //String business_name = "loading";

  getbusiness() {
    FirebaseFirestore.instance
        .collection('seller')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print("here is the bussniess name");
      print(value.get("busines-name"));
      setState(() {
        // seller_phone = value.get("seller_Phone");
        business_name = value.get("busines-name");
        owner_name = value.get("name");
        seller_phone = value.get("number");
      });
    }).then((value) {
      FirebaseFirestore.instance
          .collection("order")
          .where("busines_name", arrayContains: business_name)
          .snapshots()
          .forEach((element) {
        print("yaaaaaaaahoœ");
        print(element.docs.length);
        if (element.docs.length != 0) {
          setState(() {
            checkisexsist = true;
            order = element.docs.length;
          });
        } else {
          setState(() {
            checkisexsist = false;
            order = element.docs.length;
          });
        }
      });
    });
  }

  getresponse() {
    FirebaseFirestore.instance
        .collection('seller')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      var val = value.get("status");
      print(val);
      print("local" + check);
      if (val == "success") {
        setState(() {
          status = true;
        });
      } else if (val == "waiting") {
        status = false;
      } else {
        print("object");
      }
    });
  }

  getOrderindex() {
    FirebaseFirestore.instance
        .collection("order")
        .where("busines_name", arrayContains: business_name)
        .snapshots()
        .forEach((element) {
      print(element.docs.length);
      if (element.docs.length != 0) {
        setState(() {
          order = element.docs.length + 1;
        });
      } else {
        setState(() {
          order = element.docs.length;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getbusiness();

    //getOrderindex();
    getresponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          business_name,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        // actions: const [
        //   Icon(
        //     Icons.notifications,
        //     size: 30,
        //     color: Colors.white,
        //   ),
        // ],
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Column(
                    children: [
                      Text(owner_name),
                      Text(business_name),
                      Text(seller_phone),
                    ],
                  ),
                ),
                const Divider(
                  height: 30,
                ),
              ],
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.home),
              title: const Text("Home"),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Onbaord()));
                });
              },
              leading: const Icon(Icons.logout_sharp),
              title: const Text("Logout"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
                alignment: Alignment.topCenter,
                color: Colors.blue[900],
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                      color: Colors.white,
                      child: Column(
                        children: const [
                          Text(
                            'Wallet',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'PKR5000',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => Create_bill())));
                                },
                                child: myContainer(
                                    "Create Bills",
                                    "Create bills in pdf files",
                                    Icons.dock_rounded),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (status == true) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((context) => Upload_Products(
                                            busines_name: business_name,
                                            seller_number: seller_phone)),
                                      ),
                                    );
                                  } else {
                                    cameradialog();
                                  }
                                },
                                child: myContainer(
                                    "Upload product",
                                    "Upload product and details",
                                    Icons.preview_outlined),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => ViewOrders(
                                            busines_name: business_name,
                                          ))));
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Column(
                                        children: const [
                                          Icon(
                                            Icons.store,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "View Orders",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Manage and view orders",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            order.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                          // : CircularProgressIndicator(
                                          //     color: Colors.white,
                                          //   ),
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (business_name != "loading") {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: ((context) => Hisab(
                                                  busniessnaame: business_name,
                                                ))));
                                  }
                                },
                                child: myContainer("Hisab", "view sales report",
                                    Icons.dock_rounded),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  cameradialog() {
    AwesomeDialog(
      customHeader: Container(
        height: 80,
        width: 80,
        child: Icon(Icons.person_pin_circle_outlined),
      ),
      context: context,
      dialogBackgroundColor: Colors.black,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
      width: 380,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: Column(
        children: const [
          Text('Contact to Admin',
              style: TextStyle(
                  color: Colors.orange, fontFamily: "new", fontSize: 22)),
          Text("03323319209",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "new",
              )),
        ],
      ),
      btnOkText: "ok",
      showCloseIcon: true,
      btnOkOnPress: () async {
        //Navigator.pop(context);
      },
    ).show();
  }
}

Widget myContainer(
  String title,
  subtitle,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey)),
    child: Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          maxLines: 2,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ],
    ),
  );
}
