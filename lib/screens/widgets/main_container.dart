import 'dart:io';
import 'dart:typed_data';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poetry_publisher/comment.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/login.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/signing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class maincontainer extends StatefulWidget {
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
  State<maincontainer> createState() => _maincontainerState();
}

class _maincontainerState extends State<maincontainer> {
  Uint8List? bt;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Uint8List? bt;

    return Column(
      children: [
        xonvertimg(size: size, poetry: widget.poetry, p_name: widget.p_name),
        if (bt != null)
          Image.memory(
            bt!,
            // scale: 0.500,
            // height: 100,
          ),
        Container(
          margin: EdgeInsets.only(bottom: 15.0),
          width: size.width * 0.9,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/henry.jpg'),
                fit: BoxFit.fill,
              ),
              color: Color.fromARGB(255, 0, 0, 0),
              border: Border.all(color: Color.fromARGB(255, 217, 214, 214)),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10.0))),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: widget.onPressed, icon: widget.icon),
              Text("${widget.likecount}"),
              // SizedBox(
              //   width: size.width * 0.45,
              // ),
              Spacer(),
              Container(
                child: IconButton(
                    onPressed: widget.ontap, icon: Icon(Icons.comment)),
              ),
              // Container(height: 10, width: 10, child: CommentBox()),
              IconButton(
                  onPressed: () {
                    // var btt = UriData.fromBytes(bt!);
                    Share.share("${widget.poetry}\n\t\t${widget.p_name}");
                  },
                  icon: Icon(Icons.text_fields)),
              IconButton(
                  onPressed: () async {
                    final control = ScreenshotController();
                    final c = await control
                        .captureFromWidget(xonvertimg(
                      poetry: widget.poetry,
                      p_name: widget.p_name,
                      size: size,
                    ))
                        .then((Uint8List image) async {
                      if (image != null) {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/image.png').create();
                        await imagePath.writeAsBytes(image);

                        /// Share Plugin
                        await Share.shareFiles([imagePath.path]);
                      }
                    });
                    setState(() {
                      this.bt = c;
                    });
                    print(c);

                    try {
                      var im = MemoryImage(c);
                      // Share.shareFiles(im. , text: "file");
                      // Share.share(im.bytes)
                    } catch (e) {
                      print(e);
                    }
                    // Share.share("${poetry}\n\t\t${p_name}");
                  },
                  icon: Icon(Icons.image, color: Color.fromARGB(255, 0, 0, 0))),
              IconButton(
                  onPressed: () {
                    print("object");
                    Clipboard.setData(ClipboardData(
                            text: "${widget.poetry}\n\t\t${widget.p_name} "))
                        .then((value) => Fluttertoast.showToast(
                            msg: "Copied",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 6,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0));
                  },
                  icon: Icon(Icons.copy, color: Color.fromARGB(255, 0, 0, 0))),
            ],
          ),
        ),
      ],
    );
  }
}

class xonvertimg extends StatelessWidget {
  double? height;

  xonvertimg({
    Key? key,
    this.size,
    required this.poetry,
    this.height,
    required this.p_name,
  }) : super(key: key);

  final Size? size;
  final String poetry;
  final String p_name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),

      // padding: const EdgeInsets.all(3.0),
      // height: size.height * 0.2,
      height: height,
      width: size!.width * 0.9,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/henry.jpg'),
            fit: BoxFit.fill,
          ),
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
      child: Wrap(
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
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
        ],
      ),
    );
  }
}
