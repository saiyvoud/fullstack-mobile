import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:restaurant_app/model/product_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProductService {
  Future<List<ProductModel>> getProduct() async {
    try {
      final result = await rootBundle.loadString('assets/product.json');
      var jsonData = json.decode(result);
      print(jsonData);
      final data = await productModelFromJson(result);

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
