import 'package:flutter/cupertino.dart';
import 'package:nav_service/nav_service.dart';
import 'package:restaurant_app/components/apiPath.dart';
import 'package:restaurant_app/components/hiveDatabase.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confrimPassword = TextEditingController();
  dynamic _user;
  dynamic get user => _user;
  bool _loading = false;
  bool get loading => _loading;
  clearRegister() {
    fullname.clear();
    phoneNumber.clear();
    email.clear();
    password.clear();
    confrimPassword.clear();
  }

  Future<void> Exit() async {
    _loading = true;
    try {
      final result = await Hivedatabase.deleteToken();
      if (result == true) {
        _loading = false;
        NavService.pushReplacementNamed(RouterPath.login);
        notifyListeners();
      }
    } catch (e) {
      _loading;
      notifyListeners();
    }
  }

  Future<void> getProfile() async {
    _loading = true;
    try {
      final result = await AuthService().getProfile();
      if (result != null) {
        _user = result;
        _loading = false;
        MessageHepler.showMessage(true, "Get Profile Success");
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> RefreshToken() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final result = await Hivedatabase.getToken();
      print(result);
      if (result == null) {
        NavService.pushNamed(RouterPath.login);
      } else {
        final data = await AuthService().RefreshToken(
          refreshToken: result['refreshToken'],
        );
        if (data == true) {
          NavService.pushReplacementNamed(RouterPath.bottom);
        } else {
          NavService.pushNamed(RouterPath.login);
          MessageHepler.showMessage(false, "Refresh Token Faild");
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> Login() async {
    _loading = true;
    try {
      final result = await AuthService().Login(
        email: email.text,
        password: password.text,
      );
      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "Login Success");
        await getProfile();
        NavService.pushNamedAndRemoveUntil(RouterPath.bottom);
        notifyListeners();
      } else {
        MessageHepler.showMessage(false, "Email & password not match");
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "Email & password not match");
      notifyListeners();
    }
  }

  Future<void> Register() async {
    _loading = true;
    try {
      final result = await AuthService().Register(
        fullname: fullname.text,
        email: email.text,
        phoneNumber: phoneNumber.text,
        password: password.text,
      );

      if (result == true) {
        _loading = false;

        MessageHepler.showMessage(true, "Register Success");
        NavService.pushNamed(RouterPath.login);
        clearRegister();
        notifyListeners();
      } else {
        MessageHepler.showMessage(false, "Faild Register");
      }
    } catch (e) {
      print(e);
      _loading = false;
      MessageHepler.showMessage(false, "Faild Register");
      notifyListeners();
    }
  }
}
