import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/login.dart';
import 'package:poetry_publisher/screens/widgets/main_container.dart';
import 'package:poetry_publisher/tesying.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  int _itemCount = data!["like"];

// Text(snapshot.data!.docs[index]["shair"].toString())
                  return maincontainer2(
                      icon: Icon(Icons.favorite),
                      onPressed: () async {
                        var userrid = FirebaseAuth.instance.currentUser!.uid;
                        var store = await FirebaseFirestore.instance;
                        Map uid = data["uid"];
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var login3 = prefs.getString("email");
                        print("object");
                        if (login3 == null) {
                          Get.to(login());
                        } else {
                          try {
                            // if (uid.isEmpty || uid.keys != userrid.toString()) {
                            //   print("id empty");
                            //   print(userrid);
                            //   store.collection("gazal").doc(data.id).update(
                            //       {"like": _itemCount, "uid.$userrid": false});
                            // } else
                            if (data["uid"]["$userrid"] == false) {
                              _itemCount--;

                              await store
                                  .collection("gazal")
                                  .doc(data.id)
                                  .update({
                                "like": _itemCount,
                                "uid.$userrid": true
                              });
                            } else if (data["uid"]["$userrid"] == true ||
                                uid.keys != userrid) {
                              _itemCount++;
                              await store
                                  .collection("gazal")
                                  .doc(data.id)
                                  .update({
                                "like": _itemCount,
                                "uid.$userrid": false
                              });
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      poetry: data["poetry"].toString(),
                      p_name: data["p_name"].toString());
                });
          }),
    );
  }
}
