import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/Seller%20accounts/seller-login.dart';
import 'package:multivendor/screens/shopkeeper/Seller%20accounts/seller_detail.dart';
import 'package:multivendor/screens/user/Customer%20account/Userlogin.dart';
import 'package:multivendor/screens/user/User%20home%20/user-home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Seller_Register extends StatelessWidget {
  Seller_Register({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Craete Seller Account ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   child: TextField(
                  //     controller: nameController,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       labelText: 'Full Name',
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Enter more then 6 number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Userlogin()));
                    },
                    child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Register',
                              style: TextStyle(fontSize: 20)),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await firebaseAuth
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim())
                                  .then(
                                (value) {
                                  FirebaseFirestore.instance
                                      .collection("seller")
                                      .doc(value.user!.uid)
                                      .set({
                                    "name": nameController.text.trim(),
                                    "email": emailController.text.trim(),
                                    "id": value.user!.uid,
                                    "busines-name": "none",
                                    "store_type": "none",
                                    "address": "none",
                                    "city": "none"
                                  }).then(
                                    (value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Seller_Detail()),
                                    ),
                                  );
                                },
                              );
                            }

                            // print(nameController.text);
                            // print(passwordController.text);
                          },
                        )),
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Already Have account..?',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Userlogin()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
