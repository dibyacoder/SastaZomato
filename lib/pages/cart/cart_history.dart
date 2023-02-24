import 'dart:convert';

import 'package:ecomapp/controller/car_controller.dart';
import 'package:ecomapp/models/cart_models.dart';
import 'package:ecomapp/pages/cart/cart_page.dart';
import 'package:ecomapp/routes/route_helper.dart';
import 'package:ecomapp/utils/app_constants.dart';
import 'package:ecomapp/widgets/reusable_icons.dart';
import 'package:ecomapp/widgets/smallfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../base/no_items_page.dart';
import '../../widgets/general_font.dart';
import 'package:ecomapp/utils/dimensions.dart';

class cart_history_page extends StatelessWidget {
  const cart_history_page({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistorylist =
        Get.find<CartController>().getCartHistorylist().reversed.toList();
    Map<String, int> cartItemsperOrder = Map();

    for (int i = 0; i < getCartHistorylist.length; i++) {
      if (cartItemsperOrder.containsKey(getCartHistorylist[i].time)) {
        cartItemsperOrder.update(
            getCartHistorylist[i].time!, (value) => ++value);
      } else {
        cartItemsperOrder.putIfAbsent(getCartHistorylist[i].time!, () => 1);
      }
    }

    List<int> cartItemsOrdertimetoList() {
      return cartItemsperOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrdertimetoList() {
      return cartItemsperOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsperorder = cartItemsOrdertimetoList(); //4, 5

    var counter = 0;
    Widget timewidget(int index) {
      var outputdate = DateTime.now().toString();
      if (index < getCartHistorylist.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistorylist[counter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputformat = DateFormat("MM/dd/yy---hh:mm a");
        outputdate = outputformat.format(inputDate);
      }
      return general_font(text: outputdate);
    }

    return Scaffold(
      body: Column(
        children: [
          GetBuilder<CartController>(builder: (_cartController) {
            return Container(
              height: dimensions.size100,
              color: Colors.teal,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  general_font(text: "Purchase History", color: Colors.white),
                  SizedBox(width: dimensions.size15),
                  GestureDetector(
                      onTap: () {
                        _cartController.removeCartHistory();
                      },
                      child: reusable_icons(icon: Icons.delete_forever)),
                  reusable_icons(icon: Icons.shopping_cart_outlined)
                ],
              ),
            );
          }),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistorylist().length > 0
                ? Expanded(
                    child: Container(
                        margin: EdgeInsets.all(dimensions.size20),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsperorder.length; i++)
                                Container(
                                  height: dimensions.size120,
                                  width: dimensions.size210,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          dimensions.size15)),
                                  margin: EdgeInsets.only(
                                      bottom: dimensions.size15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timewidget(counter),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsperorder[i], (index) {
                                                if (counter <
                                                    getCartHistorylist.length) {
                                                  counter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: dimensions
                                                                .size10),
                                                        height:
                                                            dimensions.size30 *
                                                                2,
                                                        width:
                                                            dimensions.size30 *
                                                                2,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    dimensions
                                                                        .size10),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(AppConstants.baseUrl +
                                                                    AppConstants
                                                                        .uploadUrl +
                                                                    getCartHistorylist[
                                                                            counter -
                                                                                1]
                                                                        .img
                                                                        .toString()))),
                                                      )
                                                    : Container();
                                              })),
                                          Container(
                                            height: dimensions.size30 * 2 +
                                                dimensions.size15,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                small_font(text: "TOTAL"),
                                                general_font(
                                                  text: (itemsperorder[i]
                                                          .toString() +
                                                      "  Items"),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var ordertime =
                                                        cartOrdertimetoList();
                                                    Map<int, CartModel>
                                                        moreorder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistorylist
                                                                .length;
                                                        j++) {
                                                      if (ordertime[i] ==
                                                          getCartHistorylist[j]
                                                              .time) {
                                                        moreorder.putIfAbsent(
                                                            getCartHistorylist[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistorylist[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreorder;
                                                    Get.find<CartController>()
                                                        .addtocartlist();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                dimensions
                                                                        .size5 /
                                                                    2,
                                                            vertical: dimensions
                                                                    .size5 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    dimensions
                                                                        .size10),
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.teal)),
                                                    child: small_font(
                                                        text: "Buy Again"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )),
                  )
                : no_items_page(
                    text:
                        'You have not ordered a single times yet..Common what are you waiting for!!',
                    imagepath: "assets/images/no_order_history.png",
                  );
          })
        ],
      ),
    );
  }
}
