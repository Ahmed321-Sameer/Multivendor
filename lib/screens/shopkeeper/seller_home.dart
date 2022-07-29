import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/product-upload.dart';

class Seller_Home extends StatelessWidget {
  const Seller_Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                alignment: Alignment.topCenter,
                color: Colors.blue[900],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Forever men Store',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.notifications,
                              size: 30,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 80),
                      color: Colors.white,
                      child: Column(
                        children: const [
                          Text(
                            'Wallet',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'PKR5000',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: myContainer(
                                "Create Bills",
                                "Create bills in pdf files",
                                Icons.dock_rounded),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            Upload_Products())));
                              },
                              child: myContainer(
                                  "My Product",
                                  "Create bills in pdf files",
                                  Icons.preview_outlined),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: myContainer("View Orders",
                                "Manage and view orders", Icons.dock_rounded),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: myContainer("Hisab", "view sales report",
                                Icons.dock_rounded),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget myContainer(
  String title,
  subtitle,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey)),
    child: Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          maxLines: 2,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ],
    ),
  );
}
