import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Payableclass extends StatefulWidget {
  const Payableclass({Key? key}) : super(key: key);

  @override
  State<Payableclass> createState() => _PayableclassState();
}

class _PayableclassState extends State<Payableclass> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Self bills")
              .where("Type of bill", isEqualTo: "receivable")
              .snapshots(),
          builder: ((context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  //displaay json content
                  //  "customer name"
                  //           "total price"
                  //           "phone number"
                  //           "product price"
                  //           "Type of bill"
                  DocumentSnapshot curdoc = snapshot.data!.docs[index];
                  return Column(
                    children: [],
                  );
                });
          })),
    );
  }
}
