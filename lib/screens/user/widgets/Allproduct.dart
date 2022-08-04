import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../product-detail.dart';

class AllProduct extends StatelessWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return Container(
            margin: const EdgeInsets.all(12),
            child: MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot curdoc = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    List favrt = [];
                    favrt = curdoc.get("faavorite");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                  index: index,
                                  primg: curdoc["image link"],
                                  prname: curdoc["item name"],
                                  price: curdoc["price"],
                                  description: curdoc["item description"],
                                  fvrt: favrt,
                                  uid: curdoc.id,
                                  // primg: curdoc["image link"],
                                  // prname: curdoc["item name"],
                                  // price: curdoc["price"],
                                  // description: curdoc["item description"],
                                )));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: Hero(
                            tag: index,
                            child: Image(
                              image: NetworkImage(curdoc["image link"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(curdoc["item name"]),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Text(
                                curdoc["item description"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
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
        });
  }
}
