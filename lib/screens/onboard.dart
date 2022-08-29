import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/Home/Seller_nav.dart';
import 'package:multivendor/screens/shopkeeper/Seller%20accounts/seller-register.dart';
import 'package:multivendor/screens/user/Customer%20account/Userlogin.dart';
import 'package:multivendor/screens/user/User%20home%20/bottomnavigation.dart';

class Onbaord extends StatefulWidget {
  const Onbaord({Key? key}) : super(key: key);

  @override
  State<Onbaord> createState() => _OnbaordState();
}

class _OnbaordState extends State<Onbaord> {
  bool isuseridentifier = false;

  getuser() {
    if (!isuseridentifier) {
      FirebaseFirestore.instance
          .collection("consumer")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          setState(() {
            isuseridentifier = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Bottomsheet()),
          );
        }
      });
    }
    if (!isuseridentifier) {
      FirebaseFirestore.instance
          .collection("seller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          setState(() {
            isuseridentifier = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SellerNavBar()),
          );
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (FirebaseAuth.instance.currentUser != null) {
      print("user exsist.. check for type of user");
      getuser();
    } else {
      print("no user found");
      loadhomepaage();
    }

    super.initState();
  }

  loadhomepaage() {
    setState(() {
      isuseridentifier = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isuseridentifier
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                color: Color(0xFF01579B),
                // image: DecorationImage(
                //   image: AssetImage("assets/onboard.webp"),
                //   fit: BoxFit.fill,
                // ),
              ),
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Userlogin()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            // height: 30,
                            // width: 30,
                            decoration:
                                const BoxDecoration(color: Colors.green),
                            child: Column(
                              children: const [
                                CircleAvatar(
                                    backgroundColor: Color(0xFFAED581),
                                    radius: 40,
                                    child: Icon(
                                      Icons.lock_open_outlined,
                                      color: Colors.white,
                                    )),
                                Text("Go Shopping")
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Seller_Register()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            // height: 30,
                            // width: 30,
                            decoration: BoxDecoration(color: Color(0xFFAED581)),
                            child: Column(
                              children: const [
                                CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 40,
                                    child: Icon(
                                      Icons.shop_2_outlined,
                                      color: Colors.white,
                                    )),
                                Text("Sell online")
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
