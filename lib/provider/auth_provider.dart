import 'package:flutter/cupertino.dart';
import 'package:nav_service/nav_service.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confrimPassword = TextEditingController();

  bool _loading = false;
  bool get loading => _loading;
  clearRegister() {
    fullname.clear();
    phoneNumber.clear();
    email.clear();
    password.clear();
    confrimPassword.clear();
  }

  Future<void> Login() async {
    _loading = true;
    try {
      final result = await AuthService().Login(
        email: email.text,
        password: password.text,
      );
      if(result == true){
        _loading = false;
        MessageHepler.showMessage(true, "Login Success");
        NavService.pushNamedAndRemoveUntil(RouterPath.bottom);
        notifyListeners();
      }else{
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
