import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multivendor/screens/onboard.dart';
import 'package:multivendor/screens/user/widgets/Allproduct.dart';
import 'package:multivendor/screens/user/widgets/Banner.dart';
import 'package:multivendor/screens/user/widgets/Newarrival.dart';
import 'package:multivendor/screens/user/Userlogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multivendor/screens/user/product-detail.dart';

class Userhome extends StatefulWidget {
  @override
  _UserhomeState createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffoldKey = GlobalKey();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Home"),
          // backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.person),
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
                onTap: () {},
                leading: const Icon(Icons.person),
                title: const Text("Account"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.shopping_cart),
                title: const Text("Cart"),
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
        backgroundColor: Colors.grey[200],
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Baanner(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "New Arrivals",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "view all",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              NewArrival(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                children: const [
                  Text(
                    "All Products",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const AllProduct(),
            ]),
          ),
        ));
  }
}
