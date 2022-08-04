import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteItems extends StatefulWidget {
  @override
  _FavoriteItemsState createState() => _FavoriteItemsState();
}

class _FavoriteItemsState extends State<FavoriteItems> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("items")
            .where("faavorite",
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: 'error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var values = snapshot.data!.docs[index];
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Image(
                            image: NetworkImage(
                              values['image link'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(values['price']),
                    FavoriteButton(
                        isFavorite: true,
                        valueChanged: (_) {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(values.id)
                              .update({
                            "faavorite": FieldValue.arrayRemove(
                                [FirebaseAuth.instance.currentUser!.uid])
                          });
                        }),
                  ],
                ),
              );
            },
          );
        },
      ),
    ));
  }
}
