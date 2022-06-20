import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poetry_publisher/screens/shair.dart';
import 'package:poetry_publisher/screens/single%20Poet/single_poet.dart';
import 'package:poetry_publisher/screens/widgets/main_container.dart';

class unwaan extends StatelessWidget {
  unwaan({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('poetry').snapshots();

  @override
  Widget build(BuildContext context) {
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

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.75,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 2,
                    crossAxisCount: 3),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data?.docs[index];

                  return InkWell(
                    onTap: () {
                      Get.to(unwan_home(
                        name: data?["unwan"],
                      ));
                    },
                    child: Card(
                      elevation: 2,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Center(
                          child: Text(
                            "${data?["unwan"]}".trim(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

class unwan_home extends StatelessWidget {
  var name;

  unwan_home({Key? key, this.name}) : super(key: key);

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
            unwan_poetry(
              name: name.toString(),
            ),
            unwan_poetry_kata(
              name: name.toString(),
            ),
            unwan_poetry_gazal(
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

class unwan_poetry extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('poetry').snapshots();
  String name;
  unwan_poetry({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc, doc2;

                  print("${snapshot.data!.docs[index]["unwan"]}");
                  if (snapshot.data!.docs[index]["unwan"] == name.trim()) {
                    doc = snapshot.data!.docs[index];
                  }
                  return doc != null
                      ? maincontainer(
                          poetry: doc["poetry"], p_name: doc?["p_name"])
                      : Container();
                });
          }),
    );
  }
}

class unwan_poetry_kata extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('kata').snapshots();
  String name;

  unwan_poetry_kata({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc, doc2;

                  print("${snapshot.data!.docs[index]["unwan"]}");
                  if (snapshot.data!.docs[index]["unwan"] == name.trim()) {
                    doc = snapshot.data!.docs[index];
                  }
                  return doc != null
                      ? maincontainer(
                          poetry: doc["poetry"], p_name: doc?["p_name"])
                      : Container();
                });
          }),
    );
  }
}

class unwan_poetry_gazal extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('gazal').snapshots();
  String name;

  unwan_poetry_gazal({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc, doc2;

                  print("${snapshot.data!.docs[index]["unwan"]}");
                  if (snapshot.data!.docs[index]["unwan"] == name.trim()) {
                    doc = snapshot.data!.docs[index];
                  }
                  return doc != null
                      ? maincontainer(
                          poetry: doc["poetry"], p_name: doc?["p_name"])
                      : Container();
                });
          }),
    );
  }
}
