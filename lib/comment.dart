import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

class comment extends StatelessWidget {
  comment({Key? key}) : super(key: key);
  var com = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 100,
          child: Comment_Box(
            image: Image.asset(
              "assets/frantisek.jpg",
              height: 64,
              width: 64,
            ),
            controller: com,
            onImageRemoved: () {
              //on image removed
            },
            onSend: () {
              //on send button pressed
              print(com.text);
            },
          ),
        ),
      ],
    ));
  }
}

class Comment_Box extends StatefulWidget {
  Widget? image;

  var controller;

  var onSend;

  var inputRadius;
  var onImageRemoved;

  Comment_Box({
    Key? key,
    this.image,
    this.controller,
    this.inputRadius,
    this.onSend,
    this.onImageRemoved,
  }) : super(key: key);

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<Comment_Box> {
  Widget? image;

  @override
  void initState() {
    image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 1,
          color: Colors.grey[300],
          thickness: 1,
        ),
        SizedBox(height: 20),
        // if (image != null)
        //   _removable(
        //     context,
        //     _imageView(context),
        //   ),
        if (widget.controller != null)
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: widget.onSend,
              ),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: widget.inputRadius ?? BorderRadius.circular(32),
              ),
            ),
          ),
      ],
    );
  }

  Widget _removable(BuildContext context, Widget child) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              image = null;
              widget.onImageRemoved();
            });
          },
        )
      ],
    );
  }

  Widget _imageView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: image,
      ),
    );
  }
}
