import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:images_picker/images_picker.dart';
import 'package:multivendor/screens/shopkeeper/helper.dart';

import 'Seller_nav.dart';

class Upload_Products extends StatefulWidget {
  const Upload_Products({Key? key}) : super(key: key);

  @override
  State<Upload_Products> createState() => _Upload_ProductsState();
}

class _Upload_ProductsState extends State<Upload_Products> {
  final itemname_con = TextEditingController();
  final item_description_con = TextEditingController();
  final phoneno_con = TextEditingController();
  final price = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var random = new Random();
  String url = "";
  File? imageaddress;
  List<String> favorite = [];
  uploadimage() {
    String chlidref = random.nextInt(1000000).toString();
    FirebaseStorage.instance
        .ref("AvitRef")
        .child("${chlidref} image" + ".jpg")
        .putFile(File(imageaddress!.path))
        .then((value) async {
      print("image is successfully uploaded");
      url = await value.ref.getDownloadURL();
      print(url);
    });
  }

  cameradialog() {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Colors.black,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
      width: 380,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: Column(
        children: const [
          Text('Select the source of the image',
              style: TextStyle(
                  color: Colors.orange, fontFamily: "new", fontSize: 12)),
        ],
      ),
      btnOkText: "camera",
      btnCancelText: "Gallery",
      showCloseIcon: true,
      btnCancelOnPress: () {
        ImagesPicker.pick(
          quality: 1,
          pickType: PickType.image,
        ).then((value) async {
          //           File compressedFile = await FlutterNativeImage.compressImage(value!.first.path,
          // quality: 90,targetHeight: 600,targetWidth: 400);
          setState(() {
            imageaddress = File(value!.first.path);
          });
          uploadimage();
        });
      },
      btnOkOnPress: () {
        ImagesPicker.openCamera(
                quality: 1,
                pickType: PickType.image,
                cropOpt: CropOption(aspectRatio: CropAspectRatio.wh2x1))
            .then((value) {
          setState(() {
            imageaddress = File(value!.first.path);
          });
          uploadimage();
        });
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SellerNavBar()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        // backgroundColor: Colors.orange[900],
        centerTitle: true,
        title: const Text('Enter Details',
            style: TextStyle(
                color: Colors.black, fontFamily: "lobster", fontSize: 25)),
      ),
      body: Container(
          height: size.height,
          width: size.width,
          // color: Colors.orange,
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 18, right: 18),
                        child: GestureDetector(
                          onTap: (() {
                            cameradialog();
                          }),
                          child: Container(
                            height: size.height / 4,
                            width: size.width,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: imageaddress == null
                                ? const Center(
                                    child: Icon(Icons.add_a_photo,
                                        color: Colors.black, size: 45),
                                  )
                                : Image.file(imageaddress!, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      email_field(
                        itemname_con,
                        "enter product name",
                        "item_name",
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      email_field(item_description_con,
                          "enter product description", "item_name"),
                      const SizedBox(
                        height: 14,
                      ),
                      email_field(price, "enter product price", "phone"),
                      const SizedBox(
                        height: 14,
                      ),
                      email_field(phoneno_con, "enter number", "phone"),
                      const SizedBox(
                        height: 14,
                      ),
                      GestureDetector(
                        onTap: (() {
                          print("object");
                          if (url != "") {
                            final items = {
                              "image link": url.toString(),
                              "item name": itemname_con.text.toString().trim(),
                              "item description":
                                  item_description_con.text.toString().trim(),
                              "phone": phoneno_con.text.toString().trim(),
                              "price": price.text.toString().trim(),
                              "faavorite": favorite,
                              "uploading date":
                                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              "uploading time":
                                  "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                            };

                            // FirebaseFirestore.instance.collection("sellers").doc(FirebaseAuth.instance.currentUser!.uid).collection("seller items").add("bh")
                            FirebaseFirestore.instance
                                .collection("user")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("seller item")
                                .add(items)
                                .then((value) {
                              FirebaseFirestore.instance
                                  .collection("items")
                                  .doc()
                                  .set(items);
                              itemname_con.clear();
                              item_description_con.clear();
                              phoneno_con.clear();
                              price.clear();

                              Fluttertoast.showToast(
                                  msg: "item is successfully uploaded",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.amber,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "select the image to proceed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.amber,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sign_in_screen(),));
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.black),
                                color: Colors.blue),
                            child: const Center(
                              child: Text(
                                "upload",
                                style: TextStyle(
                                  fontFamily: "new",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
