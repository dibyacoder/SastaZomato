import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_models.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.cartList, cart);
    //print(sharedPreferences.getStringList(AppConstants.cartList));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
      //print(carts.toString());
    }

    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }
}
