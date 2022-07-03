import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poetry_publisher/screens/shair.dart';
import 'package:poetry_publisher/screens/widgets/main_container.dart';

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
          children: <Widget>[trend(), trend()],
        ),
      ),
    );
  }
}

class trend extends StatelessWidget {
  trend({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('kata').snapshots();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data?.docs[index];
// Text(snapshot.data!.docs[index]["shair"].toString())
                  return maincontainer(
                      poetry: data!["poetry"].toString(),
                      p_name: data["p_name"].toString());
                });
          }),
    );
  }
}
