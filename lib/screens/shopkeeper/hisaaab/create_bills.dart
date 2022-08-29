import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Create_bill extends StatefulWidget {
  @override
  State<Create_bill> createState() => _Create_billState();
}

class _Create_billState extends State<Create_bill> {
  bool isdate = false;
  int grand_total = 0;
  List<int> amount = [];
  List Product_name = [];
  List qanlity = [];
  String radio = "";
  List code = [];
  final _formkey = GlobalKey<FormState>();

  String? selectedDate;
  bool _isVisible = true;
  FirebaseFirestore storage = FirebaseFirestore.instance;

  final name = TextEditingController();
  final address = TextEditingController();
  final phoneno_con = TextEditingController();
  final price = TextEditingController();
  @override
  void initState() {
    name.clear();
    address.clear();
    code.clear();
    qanlity.clear();
    phoneno_con.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'New Khata',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: const [
                      Text(
                        'Customer Name',
                        style: TextStyle(
                          color: Color(0xff7e7b84),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  //                      height: 60,
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "field required";
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        //                              suffixIcon: Image.asset('assets/upload_patient_doc_btn.png'),
                        hintText: 'Customer Name',
                        hintStyle: const TextStyle(
                          color: Color(0xff9890b8),
                          fontWeight: FontWeight.w600,
                        ),
                        isDense: true,
                        //                              fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: const [
                      Text(
                        'Customer Mobile No.',
                        style: TextStyle(
                          color: Color(0xff7e7b84),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  //                      height: 60,
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "field required";
                      } else {
                        return null;
                      }
                    },
                    controller: phoneno_con,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        //                              suffixIcon: Image.asset('assets/upload_patient_doc_btn.png'),
                        hintText: 'Customer Mobile No.',
                        hintStyle: const TextStyle(
                          color: Color(0xff9890b8),
                          fontWeight: FontWeight.w600,
                        ),
                        isDense: true,
                        //                              fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Add product to creaate bill",
                      style: TextStyle(
                          color: Color(0xff7e7b84),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: storage
                          .collection("seller")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("seller item")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData)
                          return const CircularProgressIndicator();

                        return Container(
                          margin: const EdgeInsets.all(12),
                          child: MasonryGridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot curdoc =
                                  snapshot.data!.docs[index];
                              return Container(
                                padding: EdgeInsets.all(10),
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
                                        child: Center(
                                          child: Image(
                                            height: 100,
                                            width: 100,
                                            image: NetworkImage(
                                                curdoc["image link"]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  curdoc["item name"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "Price: " + curdoc["price"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "code: " +
                                                      curdoc["promo code"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              print("button  is pressed");
                                              if (grand_total == 0) {
                                                print("first item is added");
                                                setState(() {
                                                  grand_total = grand_total +
                                                      int.parse(
                                                          curdoc["price"]);
                                                });
                                                setState(() {
                                                  amount.add(int.parse(
                                                      curdoc["price"]));
                                                  Product_name.add(
                                                      curdoc["item name"]);
                                                  code.add(
                                                      curdoc.get("promo code"));
                                                  qanlity.add("1");
                                                });
                                                print(code.toList());
                                              } else {
                                                print(code.toList());
                                                print(
                                                    "there exsist product before");
                                                print(code.contains(
                                                    curdoc.get("promo code")));
                                                if (code.contains(
                                                    curdoc.get("promo code"))) {
                                                  print(
                                                      "product already added");
                                                } else {
                                                  print(
                                                      "another new product is added");
                                                  setState(() {
                                                    grand_total = grand_total +
                                                        int.parse(
                                                            curdoc["price"]);
                                                  });
                                                  setState(() {
                                                    amount.add(int.parse(
                                                        curdoc["price"]));
                                                    Product_name.add(
                                                        curdoc["item name"]);
                                                    code.add(curdoc
                                                        .get("promo code"));
                                                    qanlity.add("1");
                                                  });
                                                }
                                              }
                                            },
                                            child: Text("Add"),
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: const [
                      Text(
                        'Bill status',
                        style: TextStyle(
                            color: Color(0xff7e7b84),
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: "Payable",
                            groupValue: radio,
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                radio = val.toString();
                              });
                            }),
                        Text("Payable"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "Receivable",
                            groupValue: radio,
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                radio = val.toString();
                              });
                            }),
                        Text("Receivable"),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: const [
                      Text(
                        "Grand Total: ",
                        style: TextStyle(
                            color: Color(0xff7e7b84),
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Price: " + grand_total.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    children: const [
                      Text(
                        'Added Products will show here',
                        style: TextStyle(
                          color: Color(0xff7e7b84),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.grey.shade300,
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: amount.length,
                    itemBuilder: (context, index) {
                      if (amount.isEmpty) {
                        return Text("No item added");
                      }
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text((index + 1).toString()),
                              Column(
                                children: [
                                  Text("product name: " + Product_name[index]),
                                  Text("product price: " +
                                      amount[index].toString())
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        if (int.parse(qanlity[index]) > 1) {
                                          setState(() {
                                            grand_total =
                                                grand_total - amount[index];
                                            qanlity[index] =
                                                (int.parse(qanlity[index]) - 1)
                                                    .toString();
                                          });
                                        }
                                      },
                                      child: Icon(Icons.remove)),
                                  Text(qanlity[index]),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          grand_total =
                                              grand_total + amount[index];
                                          qanlity[index] =
                                              (int.parse(qanlity[index]) + 1)
                                                  .toString();
                                        });
                                      },
                                      child: Icon(Icons.add))
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    print("del");
                                    var totalaamountfor =
                                        int.parse(qanlity[index]) *
                                            int.parse(amount[index].toString());

                                    setState(() {
                                      grand_total =
                                          grand_total - totalaamountfor;
                                      Product_name.remove(index);
                                      amount.removeAt(index);
                                      qanlity.removeAt(index);
                                      code.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                  )),
                            ],
                          ),
                          const Divider(
                            height: 15,
                            color: Colors.black,
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Create bill'),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await FirebaseFirestore.instance
                              .collection("Self bills")
                              .add({
                            "length": Product_name.length.toString(),
                            "customer name": name.text.toString(),
                            "total price": grand_total,
                            "phone number": phoneno_con.text.toString(),
                            "product name": Product_name,
                            "product price": amount,
                            "id": FirebaseAuth.instance.currentUser!.uid,
                            "Type of bill": radio.toString(),
                          }).then((value) {
                            Fluttertoast.showToast(
                                msg: "Bill is created",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.amber,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }).then((value) {
                            setState(() {
                              Product_name.clear();
                              amount.clear();
                              grand_total = 0;
                              name.clear();
                              phoneno_con.clear();
                            });
                          });
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
