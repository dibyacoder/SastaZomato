import 'package:ecomapp/pages/homepage/food_page_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_foodpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodPageBody(),
    );
  }
}
