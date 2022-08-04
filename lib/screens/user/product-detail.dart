import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/screens/user/widgets/cart.dart';
import 'package:multivendor/screens/user/cart_clculations.dart';
import 'package:multivendor/screens/user/viewcart.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPage extends StatefulWidget {
  int index;
  String prname;
  String primg;
  String price;
  String description;
  List fvrt;
  String uid;
  ProductPage({
    required this.index,
    required this.primg,
    required this.prname,
    required this.price,
    required this.description,
    required this.fvrt,
    required this.uid,
  });

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
              cart.quantity.add(quantity);
            }
          });
        },
        child: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
        ),
        isExtended: true,
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
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
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => viewcart()));
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
                height: MediaQuery.of(context).size.height * 0.6,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                              .collection('items')
                              .doc(widget.uid)
                              .update({
                            'faavorite': FieldValue.arrayRemove(
                                [FirebaseAuth.instance.currentUser!.uid])
                          });
                        } else {
                          FirebaseFirestore.instance
                              .collection('items')
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
                      ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Color",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Image(
                              image: AssetImage("assets/product_color_img.png"),
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Image(
                              image: AssetImage("assets/product_color_img.png"),
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Image(
                              image: AssetImage("assets/product_color_img.png"),
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Quantity",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Total Price",
                          style: TextStyle(color: Colors.black45, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // color: Colors.black45,
                          // width: MediaQuery.of(context).size.width * 0.3,

                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 0) {
                                      quantity--;
                                    }
                                  });
                                },
                                child: Container(
                                  // width: MediaQuery.of(context).size .width * 0.055,
                                  // height: MediaQuery.of(context).size .height *0.03,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  // product remove
                                  child: const Icon(Icons.remove,
                                      size: 20, color: Colors.black45),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.035,
                              ),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.035,
                              ),
                              InkWell(
                                onTap: () {
                                  print(quantity);
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Container(
                                  // width: MediaQuery.of(context).size .width * 0.055,
                                  // height: MediaQuery.of(context).size .height *0.03,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
                                  ),
                                  // product add
                                  child: const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Rs${widget.price}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
                    const Text(
                      "In-house Product",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.white,
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         "Description",
              //         style: TextStyle(
              //             color: Colors.black54,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              //       Row(
              //         children: const [
              //           Icon(
              //             Icons.circle,
              //             size: 8,
              //           ),
              //           Text(
              //             "  100% Cotton",
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 17,
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         "Similar Products",
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 17,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              //       Container(
              //         height: MediaQuery.of(context).size.height * 0.25,
              //         child: ListView.builder(
              //             shrinkWrap: true,
              //             scrollDirection: Axis.horizontal,
              //             itemCount: 3,
              //             itemBuilder: (context, index) {
              //               return myContainer();
              //             }),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
