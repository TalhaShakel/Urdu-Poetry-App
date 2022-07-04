import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:poetry_publisher/comment.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/login.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/signing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class maincontainer extends StatelessWidget {
  String poetry;

  String p_name;

  var child;

  var icon;

  var onPressed;

  var likecount;
  var ontap;

  maincontainer(
      {Key? key,
      required this.poetry,
      required this.p_name,
      this.ontap,
      this.icon,
      this.onPressed,
      this.child,
      this.likecount})
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: onPressed, icon: icon),
                Text("$likecount"),
                // SizedBox(
                //   width: size.width * 0.45,
                // ),
                Spacer(),
                Container(
                  child:
                      IconButton(onPressed: ontap, icon: Icon(Icons.comment)),
                ),
                // Container(height: 10, width: 10, child: CommentBox()),
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
