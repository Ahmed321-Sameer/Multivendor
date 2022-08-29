import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multivendor/screens/onboard.dart';
import 'package:multivendor/screens/user/User%20home%20/Track%20order/Track_order.dart';
import 'package:multivendor/screens/user/User%20home%20/Track%20order/tabbar.dart';
import 'package:multivendor/screens/user/widgets/Allproduct.dart';
import 'package:multivendor/screens/user/widgets/Banner.dart';
import 'package:multivendor/screens/user/widgets/Newarrival.dart';
import 'package:multivendor/screens/user/Customer%20account/Userlogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multivendor/screens/user/User%20home%20/product-detail.dart';

class Userhome extends StatefulWidget {
  @override
  _UserhomeState createState() => _UserhomeState();
}

// Future<QuerySnapshot>? postdocs;
// searchbar(String enteredtext) {
//   postdocs = FirebaseFirestore.instance
//       .collection("All items")
//       .where("item name", isGreaterThanOrEqualTo: enteredtext)
//       .get();
//       setState((){
// postdocs;
//       });
// }

class _UserhomeState extends State<Userhome> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffoldKey = GlobalKey();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
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
                    title: Column(
                      children: [
                        // Text("name"),
                        Text(
                          firebaseAuth.currentUser!.email.toString(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 50,
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.home),
                title: const Text("Home"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => View(),
                      ));
                },
                leading: const Icon(Icons.shopping_cart),
                title: const Text("order"),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Onbaord()));
                  });
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
              // TextField(
              //   onChanged: (value){},
              //   decoration: InputDecoration( ),
              // ),
              //banner call
              Baanner(),
              //baaanner caall
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Sellers",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
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
