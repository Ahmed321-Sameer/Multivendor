import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/Seller_nav.dart';
import 'package:multivendor/screens/shopkeeper/seller_detail.dart';
import 'package:multivendor/screens/shopkeeper/seller_home.dart';
import 'package:multivendor/screens/user/User-register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multivendor/screens/user/bottomnavigation.dart';
import 'package:multivendor/screens/user/user-home.dart';

class Seller_login extends StatelessWidget {
  Seller_login({Key? key}) : super(key: key);
  TextEditingController nameController =
      TextEditingController(text: "Ab@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "123456");
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final TextEditingController econtroller =
    //     TextEditingController(text: "sameer@test.com");
    // final TextEditingController pcontroller =
    //     TextEditingController(text: "123456");

    // void login() async {
    //   FirebaseAuth auth = FirebaseAuth.instance;
    //   // FirebaseFirestore db = FirebaseFirestore.instance;
    //   final String email = econtroller.text.trim();
    //   final String password = pcontroller.text.trim();
    //   try {
    //     final UserCredential user = await auth.signInWithEmailAndPassword(
    //         email: email, password: password);
    //     print(email + "  Is logged in");
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => Userhome()));
    //   } catch (e) {
    //     print("error");
    //   }
    // }

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in To Seller Account',
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
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      print(nameController.text);
                      print(passwordController.text);
                      await firebaseAuth
                          .signInWithEmailAndPassword(
                              email: nameController.text.trim(),
                              password: passwordController.text.trim())
                          .then((value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerNavBar())));
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => Userhome()));
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}
