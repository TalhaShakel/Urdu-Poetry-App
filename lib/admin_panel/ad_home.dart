import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class A_home extends StatelessWidget {
  const A_home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(A_shair());
                },
                child: Text("Poetry")),
            ElevatedButton(
                onPressed: () {
                  Get.to(A_gazal());
                },
                child: Text("Gazal")),
            ElevatedButton(
                onPressed: () {
                  Get.to(A_kata());
                },
                child: Text("Kata"))
          ],
        ),
      ),
    );
  }
}

class A_shair extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  A_shair({Key? key}) : super(key: key);
  var poetry = TextEditingController();
  var name = TextEditingController();

  userStore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // String? uid = await FirebaseAuth.instance.currentUser!.uid;

    try {
      await db
          .collection("poetry")
          .add({"p_name": name.text, "poetry": poetry.text});
      print("User is register");
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      print("ERROR$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(30.0),
                  // height: size.height * 0.2,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/frantisek.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a valid Poetry';
                          }
                          return null;
                        },
                        controller: poetry,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: "Poetry",
                        ),
                        maxLines: null,
                        // maxLength: 8,
                      ))),
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(30.0),
                  // height: size.height * 0.2,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/frantisek.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a valid name';
                          }
                          return null;
                        },
                        controller: name,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: "Poet Name",
                        ),

                        maxLines: null,
                        // maxLength: 8,
                      ))),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      userStore();
                    }
                    // if (_) userStore();
                  },
                  child: Text("Post"))
            ],
          ),
        ),
      ),
    );
  }
}

class A_kata extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  A_kata({Key? key}) : super(key: key);
  var poetry = TextEditingController();
  var name = TextEditingController();

  userStore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // String? uid = await FirebaseAuth.instance.currentUser!.uid;

    try {
      await db
          .collection("kata")
          .add({"p_name": name.text, "poetry": poetry.text});
      print("User is register");
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      print("ERROR$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(30.0),
                  // height: size.height * 0.2,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/frantisek.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a valid Poetry';
                          }
                          return null;
                        },
                        controller: poetry,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: "Kata",
                        ),
                        maxLines: null,
                        // maxLength: 8,
                      ))),
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(30.0),
                  // height: size.height * 0.2,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/frantisek.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a valid NAme';
                          }
                          return null;
                        },
                        controller: name,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: "Poet Name",
                        ),

                        maxLines: null,
                        // maxLength: 8,
                      ))),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      userStore();
                    }
                    userStore();
                  },
                  child: Text("Post"))
            ],
          ),
        ),
      ),
    );
  }
}

class A_gazal extends StatelessWidget {
  A_gazal({Key? key}) : super(key: key);
  var poetry = TextEditingController();
  var name = TextEditingController();

  userStore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // String? uid = await FirebaseAuth.instance.currentUser!.uid;

    try {
      await db
          .collection("gazal")
          .add({"p_name": name.text, "poetry": poetry.text});
      print("User is register");
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      print("ERROR$e");
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(30.0),
                  // height: size.height * 0.2,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/frantisek.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a valid Poetry';
                          }
                          return null;
                        },
                        controller: poetry,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: "Gazal",
                        ),
                        maxLines: null,
                        // maxLength: 8,
                      ))),
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(30.0),
                  // height: size.height * 0.2,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/frantisek.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a valid Name';
                          }
                          return null;
                        },
                        controller: name,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: "Poet Name",
                        ),

                        maxLines: null,
                        // maxLength: 8,
                      ))),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      userStore();
                    }
                  },
                  child: Text("Post"))
            ],
          ),
        ),
      ),
    );
  }
}
