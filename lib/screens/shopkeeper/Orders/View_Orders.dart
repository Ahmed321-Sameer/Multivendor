import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multivendor/screens/shopkeeper/Orders/Order_detail.dart';

class ViewOrders extends StatefulWidget {
  String busines_name;
  ViewOrders({required this.busines_name});

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue[900],
          title: const Text(
            'Orders',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('order')
                .where("busines_name", arrayContains: widget.busines_name)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Fluttertoast.showToast(msg: 'error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var values = snapshot.data!.docs[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Order_Detail(
                              busines_name: widget.busines_name,
                              snapshot_id: values.id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 65,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                              "" + (index + 1).toString()))),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Customer Name:',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                values['consumer_name'],
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Address: ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // Text(
                                              //   values['address'],
                                              //   style: const TextStyle(
                                              //       color: Colors.grey,
                                              //       fontSize: 15,
                                              //       fontWeight:
                                              //           FontWeight.bold),
                                              // ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [],
                              ),
                            ]),
                          )));
                },
              );
            },
          ),
        ));
  }
}
