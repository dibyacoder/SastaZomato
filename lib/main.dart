import 'package:ecomapp/controller/car_controller.dart';
import 'package:ecomapp/routes/route_helper.dart';
import 'package:flutter/material.dart';

import 'package:ecomapp/helper/dependencies.dart' as dep;

import 'package:get/get.dart';

import 'controller/popular_product_contoller.dart';
import 'controller/recommended_product_controller.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartdata();
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: RouteHelper.getsplash(),
      getPages: RouteHelper.routes,
    );
  }
}
