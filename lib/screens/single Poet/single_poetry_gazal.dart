import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class single_poetry_gazal extends StatelessWidget {
  String name
      // id
      ;
  single_poetry_gazal({
    Key? key,
    required this.name,
    // required this.id,
  }) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('gazal').snapshots();
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
                          ? Column(children: [
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Center(
                                          child: Text(
                                            doc!["poetry"].toString() + "",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
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
                                          doc["p_name"].toString(),
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.9,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('assets/henry.jpg'),
                                            fit: BoxFit.fill,
                                          ),
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          border: Border.all(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(CupertinoIcons.heart,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              CupertinoIcons.add,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.download,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.copy,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])
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
