import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Color kcolor = Color.fromARGB(255, 7, 73, 206);

class gazal extends StatelessWidget {
  gazal({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('gazal').snapshots();
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
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        // padding: const EdgeInsets.all(3.0),
                        // height: size.height * 0.2,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: AssetImage('assets/frantisek.jpg'),
                            //   fit: BoxFit.fill,
                            // ),
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Center(
                                  child: Text(
                                    data!["poetry"].toString() + "",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Center(
                                child: Text(
                                  data["p_name"].toString(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/henry.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.heart,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.download,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.copy,
                                          color: Color.fromARGB(255, 0, 0, 0)))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
