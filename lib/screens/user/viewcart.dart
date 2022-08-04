import 'package:flutter/material.dart';
import 'package:multivendor/screens/user/widgets/cart.dart';

import 'bottomnavigation.dart';

class viewcart extends StatefulWidget {
  @override
  _viewcartState createState() => _viewcartState();
}

class _viewcartState extends State<viewcart> {
  bool refresh = false;
  bool loadcontent = false;
  int length = 0;
  double totalprice = 0.0;

  @override
  void initState() {
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

  // addDoubleToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble('doubleValue', totalprice);
  //   print(totalprice);
  // }

  deleteProduct(BuildContext context, index) {
    // cart.product.removeAt(index);
    // cart.product_image.removeAt(index);
    // cart.product_price.removeAt(index);
    // cart.quantity.removeAt(index);

    // setState(() {
    //   if (cart.product.length == 0) {
    //     loadcontent = false;
    //   }
    //   refresh = true;
    //   refresh = false;
    // });
    // totalsum();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (context) => Bottomsheet()));
        //   },
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.white,
        // ),
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.17,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
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
                      style: TextStyle(
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
          InkWell(
            onTap: () {
              // addDoubleToSF();
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => OrderScreen(
              //               addAddress: 'Select location',
              //             )));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.orange[300],
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            padding: EdgeInsets.symmetric(vertical: 8),
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
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
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
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cart.Product_name[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                            (cart.quantity[index] *
                                                    int.parse(cart
                                                        .product_price[index]))
                                                .toString(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
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
                                              setState(() {
                                                cart.quantity[index]++;
                                              }); // setState(() {
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
                : Center(
                    child: Text(
                      "back is empty",
                      style: TextStyle(fontSize: 40, color: Colors.red),
                    ),
                  )),
      ),
    );
  }
}
