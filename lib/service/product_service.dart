import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:restaurant_app/components/apiPath.dart';
import 'package:restaurant_app/components/globalKey.dart';
import 'package:restaurant_app/components/hiveDatabase.dart';
import 'package:restaurant_app/model/product_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class ProductService {
  Future<bool> deleteCartOne({
    required int index,
  }) async {
    try {
      final result = await Hivedatabase.deleteCartOne(index: index);
      if (result == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteCartAll() async {
    try {
      final result = await Hivedatabase.deleteCartAll();
      if (result == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>?> getCart() async {
    try {
      final result = await Hivedatabase.getCart();

      if (result != null) {
        return result;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateCart({
    required ProductModel data,
    required int index,
    required int amount,
    required int proQty,
  }) async {
    try {
      final result = await Hivedatabase.updateCart(
        data: data,
        index: index,
        amount: amount,
        proQty: proQty,
      );

      if (result == true) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addCart({
    required ProductModel data,
  }) async {
    try {
      final result = await Hivedatabase.addCart(data: data);
      if (result == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> CheckQRCode({required String tableID}) async {
    try {
      final token = await Hivedatabase.getToken();
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token!['token']}"
      };
      final response = await http.get(
        Uri.parse(ApiPath.checkTable + tableID),
        // headers: header,
      );
      print("========>" + response.body);
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ProductModel>?> search({
    required String search,
  }) async {
    try {
      final token = await Hivedatabase.getToken();
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token!['token']}"
      };
      final response = await http.get(
        Uri.parse(ApiPath.search + search),
        headers: header,
      );
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        final result = productModelFromJson(jsonEncode(data['data']));
        return result;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>?> getProduct() async {
    try {
      final header = {
        "Accept": "application/json",
      };
      final response = await http.get(
        Uri.parse(ApiPath.getProduct),
        headers: header,
      );
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        final result = productModelFromJson(jsonEncode(data['data']));
        return result;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
