import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sales_Report extends StatelessWidget {
  const Sales_Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5))),
                      child: Column(
                        children: [
                          Text(
                            "Rs ",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Payable',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5))),
                      child: Column(
                        children: [
                          Text(
                            'Rs. 0',
                            style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Receivable',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Self bills")
                      .where("id",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var values = snapshot.data!.docs[index];
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.grey[800]!,
                              Colors.grey[600]!,
                              Colors.grey[400]!,
                              Colors.grey[200]!,
                            ]),
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(top: 10),
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Name: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            values['customer name'],
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                      // Text(
                                      //   values['product name'].toString(),
                                      //   style: const TextStyle(
                                      //       color: Colors.grey,
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.bold),
                                      // ),

                                      Row(
                                        children: [
                                          const Text(
                                            "Total price: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            values['total price'].toString(),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Status",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(values["Type of bill"]),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black),
                                //     borderRadius: BorderRadius.circular(12)),
                                child: ExpansionTile(
                                  title: Text(
                                    "Products",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          int.parse(values.get("length")),
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12),
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: .3)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Product name : ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Spacer(),
                                                    Text(values.get(
                                                        "product name")[index])
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height: 7,
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Quantity : ",
                                                //       style: TextStyle(
                                                //           fontWeight:
                                                //               FontWeight.bold,
                                                //           color: Colors.white),
                                                //     ),
                                                //     Spacer(),
                                                //     Text(documentSnapshot.get(
                                                //             "product_quantity")[
                                                //         index])
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: 7,
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Price/item  :",
                                                //       style: TextStyle(
                                                //           fontWeight:
                                                //               FontWeight.bold,
                                                //           color: Colors.white),
                                                //     ),
                                                //     Spacer(),
                                                //     Text(documentSnapshot.get(
                                                //         "product_price")[index])
                                                //   ],
                                                // ),
                                              ],
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
