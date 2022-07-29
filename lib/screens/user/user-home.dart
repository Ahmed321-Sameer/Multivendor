import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:multivendor/screens/user/Userlogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multivendor/screens/user/product-detail.dart';

class Userhome extends StatefulWidget {
  @override
  _UserhomeState createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  int _current = 0;
  List carouselData = [
    "assets/header_img1.png",
    "assets/header_img1.png",
    "assets/header_img1.png",
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> imageList = [
    'assets/all_products1.png',
    'assets/all_products2.png',
    'assets/all_products3.png',
    'assets/all_products4.png',
  ];

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffoldKey = GlobalKey();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              Container(child: Column()),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title: const Text("Home"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: const Text("Account"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.shopping_cart),
                title: const Text("Cart"),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Userlogin()));
                },
                leading: const Icon(Icons.logout_sharp),
                title: const Text("Logout"),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();

                          // firebaseAuth.signOut().then((value) =>
                          //     Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => Userlogin())));
                        },
                        icon: const Icon(Icons.menu)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                            child: TextFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 5),
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ))),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.144,
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                            child:
                                const Icon(Icons.search, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Swiper(
                              onIndexChanged: (value) {
                                setState(() {
                                  _current = value;
                                });
                              },
                              itemCount: carouselData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Image(
                                  image: AssetImage(carouselData[index]),
                                  fit: BoxFit.cover,
                                );
                              },
                              layout: SwiperLayout.DEFAULT,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(carouselData, (value, url) {
                            return Container(
                              width: _current == value ? 35.0 : 10,
                              height: _current == value ? 10.0 : 10,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: _current == value
                                    ? BorderRadius.circular(20)
                                    : BorderRadius.circular(20),
                                color: _current == value
                                    ? Colors.blue
                                    : Colors.grey[400],
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // height:
                          // MediaQuery.of(context).size.height * 0.13,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          color: Colors.white,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.red,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             AllCategories(
                                        //                 allCategoriesModel,
                                        //                 homeAccessoriesModel)));
                                      },
                                      child: Container(
                                          child: Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/all_categories_ic.png"),
                                            ),
                                            Text(
                                              "All Categories",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                                      )),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             KitchenWare(
                                        //                 kitchenwareModel)));
                                      },
                                      child: Container(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Image(
                                            image: AssetImage(
                                                "assets/kitchenware_ic.png"),
                                          ),
                                          Text(
                                            "Kitchenware",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          )
                                        ],
                                      )),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    InkWell(
                                      onTap: () {
                                        // ToastMsg(
                                        //     "Data is not avaiable yet.",
                                        //     Colors.red);
                                      },
                                      child: Container(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Image(
                                            image: AssetImage(
                                                "assets/lamp_ic.png"),
                                          ),
                                          Text(
                                            "Lamp",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          )
                                        ],
                                      )),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             BathRommAccessories(
                                        //                 bathRoomModel)));
                                      },
                                      child: Container(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Image(
                                            image: AssetImage(
                                                "assets/bathroom_ic.png"),
                                          ),
                                          Text(
                                            "Bathroom",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          )
                                        ],
                                      )),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             FashionAccessories(
                                        //                 fashionModel)));
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Image(
                                              image: AssetImage(
                                                  "assets/fashion_ic.png"),
                                            ),
                                            Text(
                                              "Fashion",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "New Arrivals",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "view all",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Image(
                                    image:
                                        AssetImage("assets/new_arrival1.png"),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  const Text(
                                    "kitchen Shelf",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  const Image(
                                    image:
                                        AssetImage("assets/new_arrival1.png"),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  const Text(
                                    "kitchen Shelf",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  const Image(
                                    image:
                                        AssetImage("assets/new_arrival1.png"),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  const Text(
                                    "kitchen Shelf",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "All Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('sellers')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();

                              return Container(
                                margin: const EdgeInsets.all(12),
                                child: MasonryGridView.count(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot curdoc =
                                        snapshot.data!.docs[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductPage(
                                                      index: index,
                                                      price: curdoc["price"],
                                                      primg: curdoc["primg"],
                                                      prname: curdoc["prname"],
                                                    )));
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      topRight:
                                                          Radius.circular(12)),
                                              child: Hero(
                                                tag: index,
                                                child: Image(
                                                  image: NetworkImage(
                                                      curdoc["primg"]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(curdoc["prname"]),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                  Text(
                                                    curdoc["price"],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
