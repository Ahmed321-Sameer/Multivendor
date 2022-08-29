import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/screens/user/widgets/cart.dart';
import 'package:multivendor/screens/user/User%20home%20/viewcart.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPage extends StatefulWidget {
  int index;
  String prname;
  String primg;
  String price;
  String promo;
  String business_name;
  String selleruid;
  List fvrt;
  String uid;
  String seller_number;
  int prquantity;
  ProductPage(
      {required this.index,
      required this.seller_number,
      required this.primg,
      required this.prname,
      required this.price,
      required this.fvrt,
      required this.uid,
      required this.promo,
      required this.business_name,
      required this.prquantity,
      required this.selleruid});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool likeornot = false;
  @override
  void initState() {
    super.initState();
    loadcondition();
  }

  loadcondition() {
    if (widget.fvrt.contains(FirebaseAuth.instance.currentUser!.uid)) {
      setState(() {
        likeornot = true;
      });
    }
  }

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cart.checkproduct(widget.primg).then((value) {
            if (value) {
              print("product already exist");
            } else {
              setState(() {
                cart.quantity.length;
              });
              print("product is added to the list");
              cart.product_price.add(widget.price);
              cart.Product_name.add(widget.prname);
              cart.product_image.add(widget.primg);
              cart.selleruid.add(widget.selleruid);
              cart.promo_code.add(widget.promo);
              cart.marketbrands.add(widget.business_name);
              cart.quantity.add(quantity);
              cart.prquantity.add(widget.prquantity);
              if (cart.brandslisttoupload.contains(widget.business_name)) {
                print("brand is already added");
              } else {
                print("product is aalso aadded to the uplodaing list");
                cart.brandslisttoupload.add(widget.business_name);
              }
            }
          });
        },
        child: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
        ),
        isExtended: true,
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text(
          'Product Detail',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => viewcart(
                          business_name: widget.business_name,
                          seller_number: widget.seller_number)));
            },
            child: Container(
              margin: EdgeInsets.only(right: 5, top: 10),
              child: Stack(
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 35,
                  ),
                  Positioned(
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: Center(
                          child: Text(
                        cart.quantity.length.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Hero(
                        tag: widget.index,
                        child: Image(
                            image: NetworkImage(widget.primg),
                            height: 240,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.prname,
                          style: const TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (likeornot) {
                              setState(() {
                                likeornot = false;
                              });
                            } else {
                              setState(() {
                                likeornot = true;
                              });
                            }

                            if (!likeornot) {
                              FirebaseFirestore.instance
                                  .collection('All items')
                                  .doc(widget.uid)
                                  .update({
                                'faavorite': FieldValue.arrayRemove(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection('All items')
                                  .doc(widget.uid)
                                  .update({
                                'faavorite': FieldValue.arrayUnion(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                            }
                          },
                          child: Icon(
                            Icons.favorite_sharp,
                            color: likeornot ? Colors.red : Colors.grey,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Rs${widget.price}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Seller",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      widget.business_name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.seller_number,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
