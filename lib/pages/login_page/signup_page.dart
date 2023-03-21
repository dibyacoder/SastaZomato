// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:ecomapp/routes/route_helper.dart';
import 'package:ecomapp/utils/dimensions.dart';
import 'package:ecomapp/utils/utils.dart';
import 'package:ecomapp/widgets/general_font.dart';
import 'package:ecomapp/widgets/icons_and_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../widgets/smallfont.dart';

class signup_page extends StatefulWidget {
  const signup_page({super.key});

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = "";
  bool change = false;
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  moveToHome(BuildContext context) async {
    try {
      if (_formkey.currentState!.validate()) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString());
        Get.toNamed(RouteHelper.initial);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        utils().toastmessage("The password provided is too weak");
      } else if (e.code == "email-already-in-use") {
        utils().toastmessage("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }

      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $reslut");
      print(reslut.displayName);
      print(reslut.email);
      print(reslut.photoUrl);
    } catch (error) {
      print(error);
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
              SizedBox(
                height: 50,
              ),
              Text("Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(children: [
                  TextFormField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "Email", labelText: "Enter your Email"),
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
                    onPressed: () async {
                      await moveToHome(context);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      small_font(text: "Already have an account?"),
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.getlogin()),
                        child: small_font(
                          text: " log in",
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(dimensions.size20)),
                        color: Color.fromARGB(255, 0, 5, 6)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset("assets/images/google_logo.png"),
                        SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            googleLogin();
                            Get.toNamed(RouteHelper.initial);
                          },
                          child: general_font(
                            text: "Sign Up With Google",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(dimensions.size20)),
                        color: Color.fromARGB(255, 0, 5, 6)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset("assets/images/dialer2.png"),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getphone());
                          },
                          child: general_font(
                            text: "Sign Up With PhoneNo",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              )
            ]),
          ),
        ));
  }
}
