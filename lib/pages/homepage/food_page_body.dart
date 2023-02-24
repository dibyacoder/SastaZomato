import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecomapp/utils/dimensions.dart';
import 'package:ecomapp/widgets/app_column.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/popular_product_contoller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../models/product_models.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/general_font.dart';
import '../../widgets/icons_and_text.dart';
import '../../widgets/smallfont.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = dimensions.size260;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  //color: Colors.red,
                  height: dimensions.size260,

                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : Container(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.teal,
                    size: 80,
                  ),
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //Popular text*********************************************
        SizedBox(height: dimensions.size30),
        Container(
          margin: EdgeInsets.only(left: dimensions.size30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              general_font(text: 'Recommended'),
              SizedBox(width: dimensions.size10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: general_font(text: '.', color: Colors.black26),
              ),
              SizedBox(width: dimensions.size10),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: small_font(text: 'Food pairing'),
              )
            ],
          ),
        ),
        //Recommended food*****************************
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: dimensions.size15,
                          vertical: dimensions.size5,
                        ),
                        child: Row(
                          children: [
                            //image section**************
                            Container(
                              width: dimensions.size100,
                              height: dimensions.size100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(dimensions.size20),
                                color: Color.fromARGB(255, 253, 208, 200),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.baseUrl +
                                        '/uploads/' +
                                        recommendedProduct
                                            .recommendedProductList[index]
                                            .img!)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: dimensions.size45 * 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(dimensions.size20),
                                    bottomRight:
                                        Radius.circular(dimensions.size20),
                                  ),
                                  color: Color.fromARGB(245, 248, 229, 200),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: dimensions.size10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      general_font(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!),
                                      small_font(
                                          text:
                                              'With Chinese characteristics.'),
                                      Row(
                                        children: [
                                          icons_and_text(
                                            icon: Icons.circle_sharp,
                                            text: 'Nice',
                                            iconcolor: AppColors.iconColor1,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 3),
                                          icons_and_text(
                                            icon: Icons.location_on,
                                            text: '1.7 km',
                                            iconcolor: AppColors.mainColor,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 3),
                                          icons_and_text(
                                            icon: Icons.access_time_rounded,
                                            text: '32 min',
                                            iconcolor: AppColors.iconColor2,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container(
                  height: 500,
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.teal,
                      size: 80,
                    ),
                  ),
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(
                RouteHelper.getPopularFood(index, 'home'),
              );
            },
            child: Container(
              height: dimensions.size100 + dimensions.size45 * 2,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xff69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      AppConstants.baseUrl + '/uploads/' + popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: dimensions.size45 * 2 + dimensions.size10,
              margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(dimensions.size20),
                  color: index.isEven ? Color(0xff69c5df) : Color(0xFF9294cc),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                child: app_column(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
