import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_models.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.cartList);
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

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    List<CartModel> cartHistoryList = [];

    cartHistory.forEach((element) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartHistoryList;
  }

  void addtoCartHistorylist() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.cartHistoryList, cartHistory);
    print("the length of the cart history list is " +
        getCartHistoryList().length.toString());
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.cartList);
  }
}
