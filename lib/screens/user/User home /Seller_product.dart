import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multivendor/screens/shopkeeper/Home/Seller_nav.dart';
import 'package:multivendor/screens/shopkeeper/Products/update_product.dart';
import 'package:multivendor/screens/user/User%20home%20/product-detail.dart';

class SellerProduct extends StatefulWidget {
  SellerProduct({required this.id, required this.busines_name});
  String id;
  String busines_name;

  @override
  State<SellerProduct> createState() => _SellerProductState();
}

class _SellerProductState extends State<SellerProduct> {
  FirebaseFirestore storage = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text(widget.busines_name),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (context) => BottomAppBar()));
        //   },
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.white,
        // ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: storage
              .collection("seller")
              .doc(widget.id)
              .collection("seller item")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            return Container(
              margin: const EdgeInsets.all(12),
              child: MasonryGridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot curdoc = snapshot.data!.docs[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: GestureDetector(
                      onTap: () {
                        List favrt = [];
                        favrt = curdoc.get("faavorite");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                      selleruid: curdoc["seller_id"],
                                      index: index,
                                      primg: curdoc["image link"],
                                      prname: curdoc["item name"],
                                      price: curdoc["price"],
                                      promo: curdoc["promo code"],
                                      business_name: curdoc["business_name"],
                                      fvrt: favrt,
                                      uid: curdoc.id,
                                      seller_number: curdoc["seller_number"],

                                      prquantity: curdoc["quantity"],
                                      // prname: curdoc["item name"],
                                      // price: curdoc["price"],
                                      // description: curdoc["item description"],
                                    )));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: Hero(
                                tag: index,
                                child: Image(
                                  image: NetworkImage(curdoc["image link"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(curdoc["item name"]),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Text(
                                    curdoc["item description"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
