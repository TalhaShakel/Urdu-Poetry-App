import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:poetry_publisher/admin_panel/ad_home.dart';
import 'package:poetry_publisher/screens/gazal.dart';
import 'package:poetry_publisher/screens/kata.dart';
import 'package:poetry_publisher/screens/shair.dart';

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
      home: A_home(),
    );
  }
}

class login extends StatelessWidget {
  var tabController;

  login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kcolor,
          title: const Text("شاعری پبلشر"),
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
                Tab(
                  text: "شاعر",
                ),
                Tab(
                  text: "عنوان",
                )
              ]),
        ),
        body: TabBarView(
          children: [
            shair(),
            kataa(),
            gazal(),
            Center(
              child: Text("data4"),
            ),
            Center(
              child: Text("data4"),
            )
          ],
        ),
      ),
    );
  }
}
