import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poetry_publisher/main.dart';
import 'package:poetry_publisher/screens/Auth%20Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signnin extends StatelessWidget {
  var name = TextEditingController();

  var password = TextEditingController();

  var Email = TextEditingController();

  signnin({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: kcolor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 30, bottom: 30),
                    child: usernaem(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else
                            return null;
                        },
                        name: Email,
                        hintText: "xyz@gmail.com",
                        labelText: "Enter your Email",
                        prefixIcon: Icons.mail),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0),
                    child: usernaem(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else
                            return null;
                        },
                        name: name,
                        hintText: "Talha",
                        labelText: "Enter your Name",
                        prefixIcon: Icons.person),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 30, bottom: 20),
                    child: user_pass(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else if (value.length < 6) {
                          return "Password should be atleast 6 characters";
                        } else if (value.length > 15) {
                          return "Password should not be greater than 15 characters";
                        } else
                          return null;
                      },
                      name: password,
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                          onPressed: () async {
                            formkey.currentState!.validate()
                                ? await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                    email: Email.text,
                                    password: password.text,
                                  )
                                    .then((value) async {
                                    FirebaseFirestore.instance
                                        .collection("user")
                                        .doc(value.user?.uid)
                                        .set({
                                      "email": value.user!.email?.trim(),
                                      "password": password.text..trim(),
                                      "uid": value.user!.uid..trim(),
                                      "displayName": name.text..trim()
                                    });
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString(
                                        'email', 'useremail@gmail.com');

                                    var auth =
                                        await FirebaseAuth.instance.currentUser;

                                    print("${value.user?.email}  credential");
                                    value.additionalUserInfo?.username;
                                  }).then((value) {
                                    Get.to(home_page());
                                  }).catchError((error) => print(error))
                                : print("Not Validated");
                          },
                          child: Text("Login"))),
                  TextButton(
                      onPressed: () {
                        Get.to(login());
                      },
                      child: Text("Already have an account? "))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class usernaem extends StatelessWidget {
  var validator;

  var onTap;

  var hintText;

  var labelText;

  IconData? prefixIcon;

  usernaem({
    Key? key,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.onTap,
    this.validator,
    this.name,
  }) : super(key: key);

  final TextEditingController? name;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onTap: onTap,
      controller: name,
      decoration: InputDecoration(
        hintText: hintText,
        // helperText: '',
        labelText: labelText,

        fillColor: Color.fromARGB(255, 182, 222, 255),
        filled: true,
        hoverColor: Color.fromARGB(255, 0, 140, 255),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        icon: Icon(
          Icons.circle,
          size: 13,
        ),
        prefixIcon: Icon(prefixIcon),
        // suffixIcon: Icon(Icons.nam),
      ),
    );
  }
}

class user_pass extends StatefulWidget {
  var validator;
  user_pass({
    Key? key,
    this.validator,
    required this.name,
  }) : super(key: key);

  final TextEditingController name;

  @override
  State<user_pass> createState() => _user_passState();
}

class _user_passState extends State<user_pass> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () => setState(() {
        _passwordVisible = !_passwordVisible;
      }),
      validator: widget.validator,
      controller: widget.name,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        hintText: 'abc123',
        // helperText: '',
        labelText: 'Enter Your password',
        fillColor: Color.fromARGB(255, 182, 222, 255),
        filled: true,
        hoverColor: Color.fromARGB(255, 0, 140, 255),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        icon: Icon(
          Icons.circle,
          size: 13,
        ),
        prefixIcon: Icon(Icons.lock),
        suffixIcon:
            Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
