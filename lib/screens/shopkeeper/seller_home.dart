import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/View_Orders.dart';
import 'package:multivendor/screens/shopkeeper/create_bills.dart';
import 'package:multivendor/screens/shopkeeper/hisab.dart';
import 'package:multivendor/screens/shopkeeper/product-upload.dart';
import 'package:multivendor/screens/shopkeeper/Seller_nav.dart';

import '../onboard.dart';

class Seller_Home extends StatelessWidget {
  Seller_Home({Key? key}) : super(key: key);
  final GlobalKey _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forever men Store',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: const [
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
        ],
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
                  title: Text(
                    firebaseAuth.currentUser!.email.toString(),
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
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Onbaord()));
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          Upload_Products())));
                                },
                                child: myContainer(
                                    "My Product",
                                    "Create bills in pdf files",
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
                                      builder: ((context) => ViewOrders())));
                                },
                                child: myContainer(
                                    "View Orders",
                                    "Manage and view orders",
                                    Icons.dock_rounded),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => Hisab())));
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
