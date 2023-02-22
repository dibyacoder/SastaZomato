import 'package:ecomapp/controller/car_controller.dart';
import 'package:ecomapp/utils/app_constants.dart';
import 'package:ecomapp/widgets/reusable_icons.dart';
import 'package:ecomapp/widgets/smallfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/general_font.dart';
import 'package:ecomapp/utils/dimensions.dart';

class cart_history_page extends StatelessWidget {
  const cart_history_page({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistorylist = Get.find<CartController>().getCartHistorylist();
    Map<String, int> cartItemsperOrder = Map();

    for (int i = 0; i < getCartHistorylist.length; i++) {
      if (cartItemsperOrder.containsKey(getCartHistorylist[i].time)) {
        cartItemsperOrder.update(
            getCartHistorylist[i].time!, (value) => ++value);
      } else {
        cartItemsperOrder.putIfAbsent(getCartHistorylist[i].time!, () => 1);
      }
    }

    List<int> cartOrdertimetoList() {
      return cartItemsperOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsperorder = cartOrdertimetoList(); //4, 5

    var counter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.teal,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                general_font(text: "Purchase History", color: Colors.white),
                reusable_icons(icon: Icons.shopping_cart_outlined)
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.all(dimensions.size20),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      for (int i = 0; i < cartItemsperOrder.length; i++)
                        Container(
                          height: dimensions.size100,
                          width: dimensions.size210,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(dimensions.size15)),
                          margin: EdgeInsets.only(bottom: dimensions.size15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (() {
                                DateTime parseDate =
                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                        getCartHistorylist[counter].time!);
                                var inputDate =
                                    DateTime.parse(parseDate.toString());
                                var outputformat =
                                    DateFormat("MM/dd/yy---hh:mm a");
                                var outputdate = outputformat.format(inputDate);
                                return general_font(text: outputdate);
                              }()),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsperorder[i],
                                          (index) {
                                        if (counter <
                                            getCartHistorylist.length) {
                                          counter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    right: dimensions.size10),
                                                height: dimensions.size30 * 2,
                                                width: dimensions.size30 * 2,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            dimensions.size10),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            AppConstants
                                                                    .baseUrl +
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
                                          text: (itemsperorder[i].toString() +
                                              "  Items"),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: dimensions.size5,
                                              vertical: dimensions.size5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      dimensions.size10),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.teal)),
                                          child: small_font(text: "View More"),
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
        ],
      ),
    );
  }
}
