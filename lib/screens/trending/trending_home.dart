import 'package:flutter/material.dart';
import 'package:poetry_publisher/screens/shair.dart';

class trending extends StatelessWidget {
  const trending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: kcolor,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    indicatorColor: Colors.white,
                    labelStyle: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Family Name'), //For Selected tab
                    unselectedLabelStyle:
                        TextStyle(fontSize: 14.0, fontFamily: 'Family Name'),
                    tabs: [Text("Trending"), Text("Latest")],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: <Widget>[Text("Lunches Page")],
            ),
            Column(
              children: <Widget>[Text("Cart Page")],
            )
          ],
        ),
      ),
    );
  }
}
