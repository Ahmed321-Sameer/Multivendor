import 'package:flutter/material.dart';
import 'package:multivendor/screens/user/cart_clculations.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Cart_Calculation.price.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: [
              Text(Cart_Calculation.price[index]),
              Text(Cart_Calculation.price[index]),
              Text(Cart_Calculation.price[index]),
            ],
          ),
        );
      },
    );
  }
}
