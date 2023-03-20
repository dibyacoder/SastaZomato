// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:ecomapp/pages/login_page/signup_page.dart';
import 'package:ecomapp/routes/route_helper.dart';
import 'package:ecomapp/utils/utils.dart';
import 'package:ecomapp/widgets/general_font.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../widgets/smallfont.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = "";
  bool change = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  moveToHome(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      login();
      //Get.toNamed(RouteHelper.initial);
    }
  }

  Future<void> login() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      Get.toNamed(RouteHelper.initial);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        utils().toastmessage("No user found on this email");
      } else if (e.code == "wrong-password") {
        utils().toastmessage("You have entered invalid password");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.orange,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(children: [
              Container(
                width: double.maxFinite,
                child: Image.asset(
                  "assets/images/logo1.png",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text("Welcome bro",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(children: [
                  TextFormField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "Email", labelText: "Enter your email"),
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "name can't be empty";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Pintu@123",
                        labelText: "Enter Your Password"),
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password can't be empty";
                      } else if (value.length < 6) {
                        return "password should be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    // ignore: sort_child_properties_last
                    child: Icon(Icons.signal_cellular_0_bar_outlined,
                        color: Colors.white),

                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      backgroundColor: Colors.black, // <-- Button color
                      foregroundColor: Colors.grey, // <-- Splash color
                    ),
                    onPressed: () {
                      moveToHome(context);
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      small_font(text: "Don't have an account?"),
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.signupPage),
                        child: small_font(
                          text: " Sign up",
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ]),
              )
            ]),
          ),
        ));
  }
}
