import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bottomnavigation.dart';

class FavoriteItems extends StatefulWidget {
  @override
  _FavoriteItemsState createState() => _FavoriteItemsState();
}

class _FavoriteItemsState extends State<FavoriteItems> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Bottomsheet()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),

          backgroundColor: Colors.blue[900],
          centerTitle: true,
          title: Text("Favorite"),
          // backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("All items")
                .where("faavorite",
                    arrayContains: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Fluttertoast.showToast(msg: 'error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var values = snapshot.data!.docs[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Center(
                          child: Image(
                            image: NetworkImage(
                              values['image link'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(values['item name']),
                      subtitle: Text(values['item description']),
                      trailing: FavoriteButton(
                          isFavorite: true,
                          valueChanged: (_) {
                            FirebaseFirestore.instance
                                .collection('All items')
                                .doc(values.id)
                                .update({
                              "faavorite": FieldValue.arrayRemove(
                                  [FirebaseAuth.instance.currentUser!.uid])
                            });
                          }),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
