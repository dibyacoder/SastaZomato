import 'dart:async';

import 'package:ecomapp/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class splash_page extends StatefulWidget {
  const splash_page({super.key});

  @override
  State<splash_page> createState() => _splash_pageState();
}

class _splash_pageState extends State<splash_page>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/images/logo4.png", width: 400)),
        ],
      ),
    );
  }
}
