import 'package:flutter/material.dart';
import 'package:multivendor/screens/shopkeeper/hisaaab/khata_Register.dart';
import 'package:multivendor/screens/shopkeeper/reports/dailyreport.dart';
import 'package:multivendor/screens/shopkeeper/reports/monthalyreport.dart';

class reportbar extends StatefulWidget {
  reportbar({
    Key? key,
  }) : super(key: key);

  @override
  State<reportbar> createState() => _reportbarState();
}

class _reportbarState extends State<reportbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController1;
  @override
  void initState() {
    // initialise your tab controller here

    super.initState();
    _tabController1 = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Report',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: TabBar(
                  controller: _tabController1,
                  unselectedLabelColor: Color(0xff9890B8),
                  labelColor: Color(0xff28476E),
                  // labelPadding: EdgeInsets.symmetric(horizontal: 5),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  tabs: <Widget>[
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Daily Report',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Monthaly Report',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController1,
                  children: [Dailyreport(), Monthlyreport()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
