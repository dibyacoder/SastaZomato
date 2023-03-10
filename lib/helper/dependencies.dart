import 'package:get/get.dart';

import '../controller/car_controller.dart';
import '../controller/popular_product_contoller.dart';
import '../controller/recommended_product_controller.dart';

import '../data/api_client.dart';
import '../data/repositories/cart_repo.dart';
import '../data/repositories/popular_product_repo.dart';
import '../data/repositories/recommended_product_repo.dart';

import '../utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedproductrepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
