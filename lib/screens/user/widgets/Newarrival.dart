import 'package:flutter/material.dart';

class NewArrival extends StatelessWidget {
  NewArrival({Key? key}) : super(key: key);
  List<String> imageList = [
    'assets/all_products1.png',
    'assets/all_products2.png',
    'assets/all_products3.png',
    'assets/all_products4.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      // MediaQuery.of(context).size.height * 0.13,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  // maxRadius: 25,
                  radius: 25,
                  child: Image(
                    image: AssetImage(imageList[index]),
                  ),
                ),
                const Text(
                  "Categories",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
