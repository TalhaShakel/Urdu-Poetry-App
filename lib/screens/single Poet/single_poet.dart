import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poetry_publisher/screens/single%20Poet/single_poet_kata.dart';
import 'package:poetry_publisher/screens/single%20Poet/single_poetry_gazal.dart';
import 'package:poetry_publisher/screens/widgets/main_container.dart';

import '../gazal.dart';
import '../kata.dart';
import '../poet_name.dart';
import '../shair.dart';

class single_poet_home extends StatelessWidget {
  String? name;
  single_poet_home({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kcolor,
          title: Text("$name"),
          // leading: ,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.apps_rounded))
          ],
          bottom: TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                  fontSize: 18.0, fontFamily: 'Family Name'), //For Selected tab
              unselectedLabelStyle:
                  TextStyle(fontSize: 14.0, fontFamily: 'Family Name'),
              tabs: [
                Tab(
                  text: "شعر",
                ),
                Tab(
                  text: "قطعہ",
                ),
                Tab(
                  text: "غزل",
                ),
                // Tab(
                //   text: "شاعر",
                // ),
                // Tab(
                //   text: "عنوان",
                // )
              ]),
        ),
        body: TabBarView(
          children: [
            single_poetry(
              name: name.toString(),
            ),
            single_poetry_kata(
              name: name.toString(),
            ),
            single_poetry_gazal(
              name: name.toString(),
            ),
            // P_name(),
            // Center(
            //   child: Text("data4"),
            // )
          ],
        ),
      ),
    );
  }
}

class single_poetry extends StatelessWidget {
  String name
      // id
      ;
  single_poetry({
    Key? key,
    required this.name,
    // required this.id,
  }) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('poetry').snapshots();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text(name),
          // ),
          body: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // if (snapshot.hasError) {
                //   return Text('Something went wrong');
                // }

                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Text("Loading");
                // }
                // if (snapshot.data!.docs == name) {
                //   print("object");
                // }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc, doc2;

                      print("${snapshot.data!.docs[index]["poetry"]}");
                      if (snapshot.data!.docs[index]["p_name"] == name.trim()) {
                        doc = snapshot.data!.docs[index];
                        // doc2 = snapshot.data!.docs[index]["poetry"];
                      }
                      return doc != null
                          ? maincontainer(
                              poetry: doc["poetry"], p_name: doc?["p_name"])
                          : Container();
                    });

                // return ListView.builder(
                //     itemCount: snapshot.data!.docs.length,
                //     itemBuilder: (context, index) {
                //       var data;
                //       if (snapshot.data!.docs[index]["p_name"] == name) {
                //         print(snapshot.data?.docs[index]["poetry"]);
                //         data = snapshot.data?.docs[index];
                //       }

                //       return
                //       );
              })),
    );
  }
}
