import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multivendor/screens/user/User%20home%20/Orders.dart';
import 'package:multivendor/screens/user/widgets/cart.dart';

import 'bottomnavigation.dart';

class viewcart extends StatefulWidget {
  @override
  String? business_name;
  String? seller_number;
  viewcart({this.business_name, this.seller_number});
  _viewcartState createState() => _viewcartState();
}

class _viewcartState extends State<viewcart> {
  String consumer = '';
  getbusiness() {
    FirebaseFirestore.instance
        .collection('consumer')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print("here is the name");
      print(value.get("name"));
      setState(() {
        // seller_phone = value.get("seller_Phone");
        consumer = value.get("name");
      });
    });
  }

  bool refresh = false;
  bool loadcontent = false;
  int length = 0;
  double totalprice = 0.0;

  @override
  void initState() {
    getbusiness();
    length = cart.Product_name.length;
    if (length != 0) {
      setState(() {
        loadcontent = true;
      });
    }
    totalsum();
    super.initState();
  }

  totalsum() {
    totalprice = 0.0;
    for (int i = 0; i < cart.quantity.length; i++) {
      setState(() {
        totalprice =
            totalprice + (cart.quantity[i] * int.parse(cart.product_price[i]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Bottomsheet()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.blue[900]!,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(.9),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      totalprice.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(30)),
            child: GestureDetector(
              onTap: () {
                getuserifno();
              },
              child: const Text(
                "Place Order",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ]),
      ),
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            child: !refresh && loadcontent
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    itemCount: cart.Product_name.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => DetailScreen(
                          //               index: index,
                          //             ))));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Hero(
                                      tag: index,
                                      child: CircleAvatar(
                                        maxRadius: 40,
                                        backgroundColor: Colors.white,
                                        child: Image(
                                          image: NetworkImage(
                                              cart.product_image[index]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "price: " + cart.Product_name[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                            (cart.quantity[index] *
                                                    int.parse(cart
                                                        .product_price[index]))
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(
                                            ("by: " + cart.marketbrands[index]),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    // delete button
                                    IconButton(
                                        onPressed: () {
                                          cart.Product_name.removeAt(index);
                                          cart.product_image.removeAt(index);
                                          cart.product_price.removeAt(index);
                                          cart.quantity.removeAt(index);
                                          cart.selleruid.removeAt(index);
                                          String brandtobedeleted =
                                              cart.marketbrands[index];
                                          cart.marketbrands.removeAt(index);
                                          if (cart.marketbrands
                                              .contains(brandtobedeleted)) {
                                            print(
                                                "there still exist some product of this brand in cart");
                                          } else {
                                            print(
                                                "there is no item of left for this brand in the cart");
                                            cart.brandslisttoupload
                                                .remove(brandtobedeleted);
                                            print("here is the list");
                                            print(cart.brandslisttoupload
                                                .toString());
                                          }

                                          setState(() {
                                            cart.quantity.length;
                                            if (cart.Product_name.length == 0) {
                                              loadcontent = false;
                                            }
                                            refresh = true;
                                            refresh = false;
                                          });
                                          totalsum();
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red)),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (int.parse(
                                                      cart.prquantity[index]) >
                                                  cart.quantity[index]) {
                                                setState(() {
                                                  cart.quantity[index]++;
                                                });
                                              }
                                              // setState(() {
                                              //   print(cart.quantity[index]);
                                              //   cart.quantity[index]++;
                                              // });
                                              totalsum();
                                            },
                                            icon: Icon(Icons.add)),
                                        Text(cart.quantity[index].toString()),
                                        IconButton(
                                            onPressed: () {
                                              if (cart.quantity[index] > 1) {
                                                setState(() {
                                                  cart.quantity[index]--;
                                                });
                                                totalsum();
                                              }
                                            },
                                            icon: Icon(Icons.remove)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                      "Cart is empty",
                      style: TextStyle(fontSize: 40, color: Colors.red),
                    ),
                  )),
      ),
    );
  }

  final numbercontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final codecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  getuserifno() {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Colors.white,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
      width: 380,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const Text('complete this form',
                style: TextStyle(
                    color: Colors.orange, fontFamily: "new", fontSize: 22)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: numbercontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "enter your number",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: addresscontroller,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  // fillColor: Colors.white,
                  hintText: "enter your address",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: codecontroller,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  // fillColor: Colors.white,
                  hintText: "enter consession code",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      btnOkText: "send order",
      btnCancelText: "Deny",
      showCloseIcon: true,
      btnOkOnPress: () async {
        if (formkey.currentState!.validate()) {
          if (cart.Product_name.isNotEmpty) {
            await FirebaseFirestore.instance.collection("order").add({
              "total item": cart.quantity.length.toString(),
              "total price": totalprice.toString(),
              "busines_name": cart.brandslisttoupload,
              "consumer_name": consumer,
              "seller_number": widget.seller_number,
              "consumer_phone": numbercontroller.text.toString(),
              "id": FirebaseAuth.instance.currentUser!.uid
            }).then((value) async {
              print("now for loop is about to laounch");
              for (int i = 0; i < cart.promo_code.length; i++) {
                print("number alterations $i");
                await FirebaseFirestore.instance
                    .collection("order")
                    .doc(value.id)
                    .collection("order list")
                    .add({
                  "quantity": cart.quantity[i].toString(),
                  "market name": cart.marketbrands[i],
                  "product_name": cart.Product_name[i],
                  "product_price": cart.product_price[i],
                  "product_image": cart.product_image[i],
                  "product_code": cart.promo_code[i],
                  "consumer_phone": numbercontroller.text.toString(),
                  "seller_number": widget.seller_number,
                  "order status": "pending",
                  "seller uid": cart.selleruid[i],
                  "address": addresscontroller.text.toString(),
                  "consumer_name": consumer.toString(),
                  "id": FirebaseAuth.instance.currentUser!.uid
                });
                // then((value) {
                //   FirebaseFirestore.instance
                //       .collection("Order history")
                //       .doc()
                //       .set({
                //     "order status": "pending",
                //     "promo_code": "pending",
                //     "product_image": "pending",
                //     "consumer_name": "pending",
                //     "busines_name": "pending",
                //     "user_id": "pending",
                //     "seller_id":
                //         "FirebaseAuth.instance.currentUser!.uid.toString()"
                //   }).

                // });

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Orders(
                //       product_name: cart.Product_name.toString(),
                //       product_img: cart.product_image.toString(),
                //       promo_code: cart.promo_code.toString(),
                //       product_price: cart.product_price.toString(),
                //       consumer_name: consumer,
                //     ),
                //   ),
                // );
              }
            }).then((value) {
              cart.Product_name.clear();
              cart.product_image.clear();
              cart.quantity.clear();
              cart.promo_code.clear();
              cart.brandslisttoupload.clear();
              cart.marketbrands.clear();
            }).then((value) {
              Fluttertoast.showToast(
                  msg: "Order placed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Bottomsheet()));
            });
            ;
          } else {
            print("list is empty");
          }
        }
      },
    ).show();
  }
}
