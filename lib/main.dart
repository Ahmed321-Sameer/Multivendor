import 'package:flutter/material.dart';
import 'package:multivendor/screens/onboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multivendor/screens/user/User%20home%20/user-home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Onbaord(),
    );
  }
}
