import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/Seller%20accounts/search_bar.dart';

class Search_type extends StatefulWidget {
  const Search_type({Key? key}) : super(key: key);

  @override
  State<Search_type> createState() => _Search_typeState();
}

class _Search_typeState extends State<Search_type> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GeeksForGeeks",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
