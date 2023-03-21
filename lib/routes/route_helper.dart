import 'package:ecomapp/pages/homepage/main_foodpage.dart';
import 'package:ecomapp/pages/login_page/phone.dart';
import 'package:ecomapp/pages/login_page/verify.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food_details/popularfood_details.dart';
import '../pages/food_details/recommended_food_details.dart';
import '../pages/homepage/home_page.dart';
import '../pages/login_page/login_page.dart';
import '../pages/login_page/signup_page.dart';
import '../pages/splash_page/splash_page.dart';

class RouteHelper {
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String splashPage = '/splash-page';
  static const String loginPage = '/login-page';
  static const String signupPage = '/signup-page';
  static const String PhonePage = '/phone-page';
  static const String VerifyPage = '/verify-page';

  static String getInitial() => '$initial';
  static String getsplash() => '$splashPage';
  static String getlogin() => '$loginPage';
  static String getphone() => '$PhonePage';
  static String getVerify() => '$VerifyPage';
  static String getsignup() => '$signupPage';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: splashPage, page: () => splash_page()),
    GetPage(name: PhonePage, page: () => MyPhone()),
    GetPage(name: VerifyPage, page: () => MyVerify()),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetail(
            pageId: int.parse(pageId!),
          );
        }),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: loginPage,
        page: () {
          return login_page();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: signupPage,
        page: () {
          return signup_page();
        },
        transition: Transition.fadeIn),
  ];
}
