import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/product-upload.dart';
import 'package:multivendor/screens/shopkeeper/seller_home.dart';
import 'package:multivendor/screens/user/user-home.dart';

import 'My-products.dart';

class SellerNavBar extends StatefulWidget {
  @override
  _BottomsheetState createState() => _BottomsheetState();
}

class _BottomsheetState extends State<SellerNavBar> {
  int currentIndex = 0;
  final screens = [
    Seller_Home(),
    My_products(),
    Upload_Products(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 18,
            unselectedFontSize: 15,
            showSelectedLabels: true,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Homet",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.back_hand_sharp),
                label: "My product",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Upload",
              ),
            ]),
      ),
    );
  }
}
