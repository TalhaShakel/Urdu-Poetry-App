import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:poetry_publisher/comment.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/login.dart';
import 'package:poetry_publisher/screens/widgets/main_container.dart';
import 'package:poetry_publisher/tesying.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Color kcolor = Color.fromARGB(255, 7, 73, 206);

class gazal extends StatefulWidget {
  gazal({Key? key}) : super(key: key);

  @override
  State<gazal> createState() => _gazalState();
}

class _gazalState extends State<gazal> {
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
                  bool uuid;
                  var userrid = FirebaseAuth.instance.currentUser!.uid;

                  Map key = data["uid"];
                  print(key.keys != userrid ? "object" : "talh");
                  print(userrid);

                  return maincontainer2(
                      icon: Icon(key.keys.isEmpty
                          ? Icons.favorite_border
                          : data["uid.$userrid"] == false
                              ? Icons.favorite
                              : Icons.favorite_border),
                      onPressed: () async {
                        var store = await FirebaseFirestore.instance;
                        Map uid = data["uid"];
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var login3 = prefs.getString("email");
                        if (login3 == null) {
                          Get.to(login());
                        } else {
                          try {
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
                        print("object");
                        // return login3 != null ? !isLiked : isLiked;
                      },
                      child: IconButton(
                          onPressed: () {
                            Get.to(comment());
                          },
                          icon: Icon(Icons.comment)),
                      poetry: data["poetry"].toString(),
                      p_name: data["p_name"].toString());
                });
          }),
    );
  }
}
