import 'dart:convert';

import 'package:http/http.dart';
import 'package:restaurant_app/components/apiPath.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/components/globalKey.dart';
import 'package:restaurant_app/components/hiveDatabase.dart';

class OrderService {
  Future<bool> updateStatus({
    required String orderID,
    required String paymentType,
    required String priceTotal,
  }) async {
    try {
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${TOKEN}"
      };
      final body = {
        "paymentType": paymentType,
        "priceTotal": priceTotal,
      };
      final response = await http.put(
        Uri.parse(ApiPath.updateStatus + orderID),
        body: body,
        headers: header,
      );

      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final result = data['data'];
        return result;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<dynamic>?> getOrderByStatus({
    required String status,
  }) async {
    try {
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${TOKEN}"
      };
      final response = await http.get(
        Uri.parse(ApiPath.getOrderByUserStatus + status),
        headers: header,
      );

      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final result = data['data'];
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getOrderDetailBy({
    required String orderID,
  }) async {
    try {
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${TOKEN}"
      };
      final response = await http.get(
        Uri.parse(ApiPath.getOrderDetailBy + orderID),
        headers: header,
      );

      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final result = data['data'];
        return result;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> order() async {
    try {
      var tableID =
          "2d3f4ac6-fb92-45af-8684-e0c0ba6996a9"; //await Hivedatabase.getToken();
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${TOKEN}"
      };

      final body = {
        "tableID": tableID,
      };
      final response = await http.post(
        Uri.parse(ApiPath.order),
        body: body,
        headers: header,
      );
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        await Hivedatabase.addOrderID(orderID: data['data']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> orderDetail({
    required List<dynamic> cart,
  }) async {
    try {
      final orderID = await Hivedatabase.getOrderID();
      Map<String, String> headers = {
        'Authorization': 'Bearer ${TOKEN}',
      };
      for (var i = 0; i < cart.length; i++) {
        final body = {
          "orderID": orderID,
          "productID": cart[i]['productID'],
          'amount': cart[i]['proQty'].toString()
        };
        final url = Uri.parse(ApiPath.orderDetail);
        final response = await http.post(
          url,
          body: body,
          headers: headers,
        );
        print(response.body);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
