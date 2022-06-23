import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:poetry_publisher/screens/widgets/main_container.dart';
import 'package:share_plus/share_plus.dart';

class test extends StatefulWidget {
  test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  // var isLiked2 = false;

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
                  var isLiked2 = false;
                  return
                      // Text("${data!["poetry"].toString()}");

                      maincontainer2(
                          icon: Icon(isLiked2 == true
                              ? Icons.favorite_border
                              : Icons.favorite),
                          onPressed: () async {
                            var store = await FirebaseFirestore.instance;
                            var userrid =
                                FirebaseAuth.instance.currentUser!.uid;
                            print("$userrid");

                            isLiked2 = data["uid"]["$userrid"];
                            if (data["uid"]["$userrid"] == false) {
                              _itemCount--;

                              await store
                                  .collection("gazal")
                                  .doc(data.id)
                                  .update({
                                "like": _itemCount,
                                "uid.$userrid": true
                              });
                            } else if (data["uid"]["$userrid"] == true) {
                              _itemCount++;
                              await store
                                  .collection("gazal")
                                  .doc(data.id)
                                  .update({
                                "like": _itemCount,
                                "uid.$userrid": false
                              });
                            }
                          }, //     // isLiked: isLiked,
                          // likeCount: data["like"],
                          // icon: Icon(isLiked2 == true
                          //     ? Icons.favorite_border
                          //     : Icons.favorite),
                          //     onPressed: () async {
                          //       // isLiked2 = data["uid"]["talha"];
                          //       // var store = await FirebaseFirestore.instance;
                          //       // Map o = data["uid"];
                          //       // if (o.keys != "talha2") {
                          //       //   store.collection("gazal").doc(data.id).update({
                          //       //     "uid2": {"talha4": false},
                          //       //     "uid": {"talha2": false, "talha3": false}
                          //       //   });
                          //       // }

                          //       // print(o.keys);
                          //       // isLiked2 == false ? isLiked2 = true : isLiked2 = false;

                          //       // setState(() {});
                          //     },
                          poetry: data["poetry"].toString(),
                          p_name: data["p_name"].toString());
                });
          }),
    );
  }
}

class maincontainer2 extends StatelessWidget {
  String poetry;

  String p_name;

  var onPressed;

  var icon;

  maincontainer2(
      {Key? key,
      required this.poetry,
      required this.p_name,
      this.icon,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(15.0),
      // padding: const EdgeInsets.all(3.0),
      // height: size.height * 0.2,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Text(
                  poetry,
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
                p_name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                border: Border.all(color: Color.fromARGB(255, 217, 214, 214)),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: onPressed, icon: icon),
                // LikeButton(
                //   onTap: onTap,
                //   likeCount: likeCount,
                //   // isLiked: isLiked,
                // ),
                IconButton(
                    onPressed: () {
                      Share.share("${poetry}\n\t\t${p_name}");
                    },
                    icon:
                        Icon(Icons.share, color: Color.fromARGB(255, 0, 0, 0))),
                IconButton(
                    onPressed: () {
                      print("object");
                      Clipboard.setData(
                              ClipboardData(text: "${poetry}\n\t\t${p_name} "))
                          .then((value) => Fluttertoast.showToast(
                              msg: "Copied",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 6,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0));
                    },
                    icon:
                        Icon(Icons.copy, color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
