import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/components/apiPath.dart';
import 'package:restaurant_app/components/globalKey.dart';
import 'package:restaurant_app/components/hiveDatabase.dart';

class AuthService {
  Future<dynamic> getProfile() async {
    try {
      final token = await Hivedatabase.getToken();
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token!['token']}"
      };
      final response = await http.get(
        Uri.parse(ApiPath.getUserOne),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (data['success'] == true) {
        return data['data'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfile({
    required String username,
    required String phoneNumber,
  }) async {
    try {
      final token = await Hivedatabase.getToken();
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token!['token']}"
      };
      final response = await http.put(
        Uri.parse(ApiPath.EditProfile),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    try {
      final token = await Hivedatabase.getToken();
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token!['token']}"
      };
      final response = await http.put(
        Uri.parse(ApiPath.changePassword),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

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

  Future<bool> RefreshToken({
    required String refreshToken,
  }) async {
    try {
      final header = {
        "Accept": "application/json",
      };
      final body = {
        "refreshToken": refreshToken,
      };
      final response = await http.put(
        Uri.parse(ApiPath.refreshToken),
        body: body,
        headers: header,
      );
      print(response.body);
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
      rethrow;
    }
  }
}
