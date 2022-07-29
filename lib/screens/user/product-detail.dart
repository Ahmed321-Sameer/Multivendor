import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPage extends StatefulWidget {
  int index;
  String prname;
  String primg;
  String price;

  ProductPage(
      {required this.index,
      required this.primg,
      required this.price,
      required this.prname});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void _ButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xff737373),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: bottommenu(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
          );
        });
  }

  Form bottommenu() {
    return Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Poduct Spacifications",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              Icon(
                Icons.close,
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Brand Name",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Name of the Brand"),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Main Material",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Pure Cotton"),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Main Material",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Pure Cotton"),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Item type",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Clothes"),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Gender",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Unisex"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myContainer() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage("assets/similar_product1.png"),
            fit: BoxFit.cover,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const Text(
            " Dish Washer Stand",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          const Text(
            " Rs. 200",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width * 0.42,
                color: Colors.blue[100],
                child: const Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.42,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.13,
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15),
                              hintText: "I'm shopping for...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.height * 0.031,
                          child: Stack(
                            children: [
                              const Icon(Icons.shopping_cart_outlined),
                              Positioned(
                                left: 10,
                                bottom: 5,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue),
                                  child: const Center(
                                      child: Text(
                                    "2",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Icon(Icons.favorite_border),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
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
                      style: TextStyle(fontSize: 19, color: Colors.black54),
                    ),
                    // Row(
                    //   children: [
                    //     RatingBar.builder(
                    //       initialRating: 3,
                    //       minRating: 1,
                    //       direction: Axis.horizontal,
                    //       allowHalfRating: true,
                    //       itemCount: 5,
                    //       unratedColor: Colors.grey[200],
                    //       itemSize: 20,
                    //       itemBuilder: (context, _) => Icon(
                    //         Icons.star,
                    //         color: Colors.amber,
                    //       ),
                    //       onRatingUpdate: (rating) {
                    //         print(rating);
                    //       },
                    //     ),
                    //     Text(
                    //       "  (5)",
                    //       style: TextStyle(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     Icon(
                    //       Icons.favorite_border,
                    //       color: Colors.red,
                    //     ),
                    //   ],
                    // ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.price,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'PKR 3000',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[400],
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
                          widget.price,
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
              InkWell(
                onTap: () {
                  _ButtonPressed();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Specifications",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      )
                    ],
                  ),
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
                      "Description",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        Text(
                          "  100% Cotton",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        const Text(
                          "  Imported",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 8,
                        ),
                        const Text(
                          "  Button Closure",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Similar Products",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return myContainer();
                          }),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
