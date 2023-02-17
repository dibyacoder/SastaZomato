import 'dart:convert';

import 'package:get/get.dart';

import '../data/repositories/recommended_product_repo.dart';
import '../models/product_models.dart';
import 'package:http/http.dart' as http;

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedproductrepo;
  RecommendedProductController({required this.recommendedproductrepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    http.Response response = await http
        .get(Uri.parse("http://mvs.bslmeiyu.com/api/v1/products/recommended"));
    if (response.statusCode == 200) {
      print("got products recommended");
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Product.fromJson(json.decode(response.body)).products);
      _isLoaded = true;
      update();
    } else {
      print('could not get products recommended');
    }
  }
}
