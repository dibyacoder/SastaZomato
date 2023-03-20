import 'package:ecomapp/utils/dimensions.dart';
import 'package:ecomapp/widgets/general_font.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/route_helper.dart';

class profile_page extends StatelessWidget {
  profile_page({super.key});
  get user => FirebaseAuth.instance.currentUser!;

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: general_font(text: "Your Profile")),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: dimensions.size15,
              vertical: dimensions.size5,
            ),
            child: Row(
              children: [
                Icon(Icons.details_sharp),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: dimensions.size30 + dimensions.size10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(dimensions.size20),
                        bottomRight: Radius.circular(dimensions.size20),
                        topLeft: Radius.circular(dimensions.size20),
                        bottomLeft: Radius.circular(dimensions.size20),
                      ),
                      color: Color.fromARGB(245, 248, 229, 200),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: dimensions.size10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: general_font(
                            text: user.displayName!,
                            size: 32,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: dimensions.size15,
              vertical: dimensions.size5,
            ),
            child: Row(
              children: [
                Icon(Icons.email),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: dimensions.size30 + dimensions.size10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(dimensions.size20),
                        bottomRight: Radius.circular(dimensions.size20),
                        topLeft: Radius.circular(dimensions.size20),
                        bottomLeft: Radius.circular(dimensions.size20),
                      ),
                      color: Color.fromARGB(245, 248, 229, 200),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: dimensions.size10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: general_font(
                            text: user.email!,
                            size: 32,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: dimensions.size15,
              vertical: dimensions.size5,
            ),
            child: Row(
              children: [
                Icon(Icons.logout_rounded),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: dimensions.size30 + dimensions.size10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(dimensions.size20),
                        bottomRight: Radius.circular(dimensions.size20),
                        topLeft: Radius.circular(dimensions.size20),
                        bottomLeft: Radius.circular(dimensions.size20),
                      ),
                      color: Color.fromARGB(245, 248, 229, 200),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: dimensions.size10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: GestureDetector(
                            onTap: () {
                              logout();
                              Get.toNamed(RouteHelper.signupPage);
                            },
                            child: general_font(
                              text: "Log Out",
                              size: 32,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
