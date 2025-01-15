import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:restaurant_app/model/product_model.dart';

class Hivedatabase {
  static Future<bool> deleteOrderID({
    required int index,
  }) async {
    try {
      final box = await Hive.openBox<dynamic>("orderID");
      await box.deleteAt(index);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<String> getOrderID() async {
    try {
      final box = await Hive.openBox<dynamic>('orderID');
      final data = await box.getAt(0);
      print("get orderID: ${data['orderID']}");
      return data['orderID'];
    } catch (e) {
      print("Error orderID: $e");
      rethrow;
    }
  }

  static Future<bool> addOrderID({required String orderID}) async {
    try {
      final box = await Hive.openBox<dynamic>('orderID');

      try {
        await box.deleteAt(0);
      } catch (e) {
        await box.add({
          "orderID": orderID,
        });

        print("Added orderID: ${orderID}");
        return true;
      }
      // Add product to cart
      await box.add({
        "orderID": orderID,
      });

      print("Added orderID: ${orderID}");
      return true;
    } catch (e) {
      print("Error orderID: $e");
      return false;
    }
  }

  static Future<bool> deleteCartAll() async {
    try {
      final box = Hive.isBoxOpen('cart')
          ? Hive.box('cart')
          : await Hive.openBox<Map<String, dynamic>>('cart');
      await box.deleteFromDisk();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteCartOne({
    required int index,
  }) async {
    try {
      final box = await Hive.openBox("cart");
      await box.deleteAt(index);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<dynamic>?> getCart() async {
    try {
      List<dynamic> data = [];
      final box = await Hive.openBox("cart");
      for (var i = 0; i < box.length; i++) {
        final result = await box.getAt(i);
        data.add(result);
      }

      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addCart({
    required ProductModel data,
  }) async {
    try {
      final box = await Hive.box<dynamic>('cart');

      // Add product to cart
      await box.add({
        "productID": data.productID,
        "proName_la": data.proName_la,
        "proDetail_la": data.proDetail_la,
        "proQty": data.proQty,
        "proPrice": data.proPrice,
        "image": data.image,
      });

      print("Added product to cart: ${data.productID}");
      return true;
    } catch (e) {
      print("Error adding product to cart: $e");
      return false;
    }
  }

  static Future<bool> updateCart({
    required ProductModel data,
    required int index,
    required int amount,
    required int proQty,
  }) async {
    try {
      // Check if the box is already open
      final box = Hive.isBoxOpen('cart')
          ? Hive.box('cart')
          : await Hive.openBox<Map<String, dynamic>>('cart');

      // Retrieve the current value of the 'cart' key (if any)
      try {
        final currentData = await box.getAt(index);
        print("=====> Hive Current Data: $currentData");

        if (currentData['productID'] == data.productID) {
          currentData['proQty'] = currentData['proQty'] + amount;
          await box.putAt(index, currentData);
          print("====> Successfully updated cart in Hive");
        }
      } catch (e) {
        await box.add({
          "productID": data.productID,
          "proName_la": data.proName_la,
          "proDetail_la": data.proDetail_la,
          "proQty": 1,
          "proPrice": data.proPrice,
          "image": data.image,
        });
        print("====> New cart entry created in Hive");

        return true;
      }
      return true;
    } catch (e) {
      print("Error updating cart: $e");
      return false;
    } finally {
      // Ensure the Hive box is closed after use
      await Hive.close();
    }
  }

  static Future<List<dynamic>?> getAllProduct() async {
    try {
      final box = await Hive.openBox<Map>('cart');
      final result = await box.get('cart');
      return [result];
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> saveToken({
    required String token,
    required String refreshToken,
  }) async {
    try {
      final box = await Hive.openBox<Map>("tokens");
      await box.deleteAll(['tokens']);
      await box.add({
        "token": token,
        "refreshToken": refreshToken,
      });
      final result = await box.getAt(0);

      print("token===>${result!['token']}");
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getToken() async {
    try {
      final box = await Hive.openBox<Map>("tokens");
      final data = await box.getAt(0);
      return data!['token'].toString();
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> deleteToken() async {
    try {
      final box = await Hive.openBox<Map>("tokens");
      await box.delete('tokens');
      return true;
    } catch (e) {
      return false;
    }
  }
}
