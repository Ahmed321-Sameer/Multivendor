import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multivendor/screens/shopkeeper/Home/Seller_nav.dart';
import 'package:multivendor/screens/shopkeeper/Products/update_product.dart';

class My_products extends StatelessWidget {
  My_products({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  update() {
    SimpleDialog(
      children: [
        Container(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
              ),
              TextFormField(
                controller: priceController,
              ),
            ],
          ),
        )
      ],
    );
  }

  FirebaseFirestore storage = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: Text("My products"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SellerNavBar()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: storage
              .collection("seller")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("seller item")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            return Container(
              margin: const EdgeInsets.all(12),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot curdoc = snapshot.data!.docs[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: Hero(
                            tag: index,
                            child: Center(
                              child: Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(curdoc["image link"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: " + curdoc["item name"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Text(
                                      "Price: " + curdoc["price"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Text(
                                      "Quantity: " + curdoc["quantity"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Update_Product(
                                              docid: curdoc.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        color: Colors.green,
                                        child: Text("update"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        storage
                                            .collection("seller")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("seller item")
                                            .doc(curdoc.id)
                                            .delete()
                                            .then((value) {
                                          FirebaseFirestore.instance
                                              .collection("All items")
                                              .where("promo code",
                                                  isEqualTo:
                                                      curdoc['promo code'])
                                              .get()
                                              .then((nestedvalue) {
                                            if (nestedvalue.size < 2)
                                              nestedvalue.docs
                                                  .forEach((element) {
                                                element.reference.delete();
                                              });
                                            Fluttertoast.showToast(
                                                msg:
                                                    "item successfully deleted",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.amber,
                                                textColor: Colors.black,
                                                fontSize: 16.0);
                                          });
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        color: Colors.red,
                                        child: Text("delete"),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
