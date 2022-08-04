import 'package:flutter/material.dart';
import 'package:multivendor/screens/user/favoriteItem.dart';
import 'package:multivendor/screens/user/user-home.dart';
import 'package:multivendor/screens/user/viewcart.dart';

class Bottomsheet extends StatefulWidget {
  @override
  _BottomsheetState createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  int currentIndex = 0;
  final screens = [
    Userhome(),
    FavoriteItems(),
    viewcart(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("App"),
          // ),
          // appBar: AppBar(
          //   title: Text("Cart App"),
          //   centerTitle: true,
          // ),
          body: screens[currentIndex],

          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.grey,
              unselectedItemColor: Colors.grey[300],
              selectedFontSize: 18,
              unselectedFontSize: 15,
              showSelectedLabels: true,
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                  ),
                  label: "Favourite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  label: "Cart",
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.check),
                //   label: "SignOut",
                // ),
              ]),
        ),
      ),
    );
  }
}
