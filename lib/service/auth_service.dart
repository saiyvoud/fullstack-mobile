import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/components/apiPath.dart';
import 'package:restaurant_app/components/hiveDatabase.dart';

class AuthService {
  Future<bool> Login({
    required String email,
    required String password,
  }) async {
    try {
      final header = {
        "Accept": "application/json",
      };
      final body = {
        "email": email,
        "password": password,
      };

      final response = await http.post(
        Uri.parse(ApiPath.login),
        body: body,
        headers: header,
      );
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
      
        await Hivedatabase.saveToken(
          token: data['data']['token'],
          refreshToken: data['data']['refreshToken'],
        );
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> Register({
    required String fullname,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final header = {
        "Accept": "application/json",
        // "content-type": "application/json"
      };
      final body = {
        "username": fullname,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
      };
      print(body);
      final response = await http.post(Uri.parse(ApiPath.register),
          body: body, headers: header);
      print("=====>");
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print("====>${e}");
      return false;
    }
  }
}
