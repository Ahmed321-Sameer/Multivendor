import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/seller-login.dart';
import 'package:multivendor/screens/shopkeeper/seller-register.dart';
import 'package:multivendor/screens/user/Userlogin.dart';

class Onbaord extends StatelessWidget {
  const Onbaord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              "Weclcome",
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Userlogin()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // height: 30,
                      // width: 30,
                      decoration: const BoxDecoration(color: Colors.green),
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
                      Navigator.pushReplacement(
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
