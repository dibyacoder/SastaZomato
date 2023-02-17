import 'package:ecomapp/widgets/smallfont.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/car_controller.dart';

import '../../controller/popular_product_contoller.dart';
import '../../controller/recommended_product_controller.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/general_font.dart';
import '../../widgets/reusable_icons.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: dimensions.size20,
              right: dimensions.size20,
              top: dimensions.size45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reusable_icons(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                  SizedBox(width: dimensions.size20 * 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: reusable_icons(
                      icon: Icons.home,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  reusable_icons(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return Positioned(
              top: dimensions.size20 * 4.5,
              left: dimensions.size20,
              right: dimensions.size20,
              bottom: 0,
              child: Container(
                //color: Colors.red,
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child:
                        GetBuilder<CartController>(builder: (cartController) {
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return Container(
                              height: dimensions.size20 * 5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex =
                                          Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                      if (popularIndex >= 0) {
                                        Get.toNamed(
                                          RouteHelper.getPopularFood(
                                              popularIndex, 'cartpage'),
                                        );
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        if (recommendedIndex < 0) {
                                          Get.snackbar('History product',
                                              'Product review is not available.');
                                        } else {
                                          Get.toNamed(
                                            RouteHelper.getRecommendedFood(
                                                recommendedIndex),
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: dimensions.size20 * 5,
                                      height: dimensions.size20 * 5,
                                      margin: EdgeInsets.only(
                                        bottom: dimensions.size10,
                                        right: dimensions.size10,
                                      ),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            AppConstants.baseUrl +
                                                AppConstants.uploadUrl +
                                                cartController
                                                    .getItems[index].img!,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          dimensions.size20,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: dimensions.size20 * 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        general_font(
                                          text: cartController
                                              .getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        small_font(text: 'Spicey'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            general_font(
                                              text: "\$ " +
                                                  cartController
                                                      .getItems[index].price
                                                      .toString(),
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                dimensions.size10,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  dimensions.size20,
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 5.0,
                                                    ),
                                                    child: general_font(
                                                      text: _cartList[index]
                                                          .quantity
                                                          .toString(),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    })),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
            height: dimensions.size100,
            padding: EdgeInsets.symmetric(
              vertical: dimensions.size10,
              horizontal: dimensions.size20,
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(dimensions.size20 * 2),
                  topRight: Radius.circular(dimensions.size20 * 2),
                )),
            child: cartController.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(dimensions.size20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(dimensions.size20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: general_font(
                                text: '\$' +
                                    cartController.totalAmount.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(dimensions.size20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(dimensions.size20),
                            color: AppColors.mainColor,
                          ),
                          child: general_font(
                            text: 'CheckOut',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container());
      }),
    );
  }
}
