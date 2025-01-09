import 'dart:convert';

import 'package:http/http.dart';
import 'package:restaurant_app/components/apiPath.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/components/hiveDatabase.dart';

class OrderService {
  Future<bool> order() async {
    try {
      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU4YWViNzlmLTViNTAtNDc5OC1hNjI2LWY1MTBkNGMyZjRlZCIsImlhdCI6MTczNjI1MTQ0OSwiZXhwIjoxNzM2MjU4NjQ5fQ.3gbCCYQQknhJXSaL5iccoWsevwetvj39c9-eT5uWy9U"; // await Hivedatabase.getToken();
      var tableID =
          "2d3f4ac6-fb92-45af-8684-e0c0ba6996a9"; //await Hivedatabase.getToken();
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token}"
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
      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU4YWViNzlmLTViNTAtNDc5OC1hNjI2LWY1MTBkNGMyZjRlZCIsImlhdCI6MTczNjI1MTQ0OSwiZXhwIjoxNzM2MjU4NjQ5fQ.3gbCCYQQknhJXSaL5iccoWsevwetvj39c9-eT5uWy9U"; // await Hivedatabase.getToken();
      final orderID = await Hivedatabase.getOrderID();
      Map<String, String> headers = {
        'Authorization': 'Bearer ${token}'
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
