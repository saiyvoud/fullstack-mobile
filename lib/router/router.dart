import 'package:flutter/material.dart';
import 'package:restaurant_app/components/bottomNavigator_widget.dart';
import 'package:restaurant_app/view/auth/login_view.dart';
import 'package:restaurant_app/view/auth/register_view.dart';
import 'package:restaurant_app/view/home_view.dart';
import 'package:restaurant_app/view/cart/bill_view.dart';

class RouterPath {
  static const String splashScreen = "/";
  static const String home = "/home";
  static const String login = "/login";
  static const String register = "/register";
  static const String bottom = "/bottom";
  static const String product = "/product";
  static const String bill = "/bill";

  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => BottomNavigatorWidget(),
        );
      case bottom:
        return MaterialPageRoute(
          builder: (_) => BottomNavigatorWidget(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => BottomNavigatorWidget(),
        );
      case bill:
        return MaterialPageRoute(
          builder: (_) => BillView(),
        );
      case product:
        return MaterialPageRoute(
          builder: (_) => HomeView(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => RegisterView(),
        );

      default:
        throw FormatException("Router not found");
    }
  }
}
