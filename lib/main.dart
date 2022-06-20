import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:poetry_publisher/admin_panel/ad_home.dart';
import 'package:poetry_publisher/ruff.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/signing.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/profile.dart';
import 'package:poetry_publisher/screens/gazal.dart';
import 'package:poetry_publisher/screens/kata.dart';
import 'package:poetry_publisher/screens/poet_name.dart';
import 'package:poetry_publisher/screens/shair.dart';
import 'package:poetry_publisher/screens/trending/trending_home.dart';
import 'package:poetry_publisher/screens/unwaan/unwan.dart';
import 'package:poetry_publisher/screens/user%20upload%20poetry/upload_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ruff(),
    );
  }
}

class home_page extends StatelessWidget {
  var tabController;

  home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        drawer: Drawer(
            // child: profile(),
            ),
        appBar: AppBar(
          backgroundColor: kcolor,
          title: const Text("شاعری پبلشر"),
          // leading: ,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(
                onPressed: () async {
                  var userData = await FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get();
                  var email = userData["email"];
                  var name = userData["displayName"];
                  print(email);

                  Get.to(profile(email: email, name: name));
                },
                icon: Icon(Icons.person))
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
                Tab(
                  text: "شاعر",
                ),
                Tab(
                  text: "عنوان",
                )
              ]),
        ),
        body: TabBarView(
          children: [shair(), kataa(), gazal(), P_name(), unwaan()],
        ),
      ),
    );
  }
}
