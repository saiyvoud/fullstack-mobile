import 'package:flutter/material.dart';
import 'package:nav_service/nav_service.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  bool _loading = false;
  // ສົ່ງຕົວປ່ຽນອອກພາຍນອກ
  bool get loading => _loading;

  Future<void> order() async {
    _loading = true;
    try {
      final result = await OrderService().order();
       NavService.pop();
      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "ອໍເດີສຳເລັດ");
        notifyListeners();
      }else{
          MessageHepler.showMessage(false, "Order Faild");
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "ອໍເດີບໍ່ສຳເລັດ $e");
      notifyListeners();
    }
  }

  Future<void> orderDetail({
    required List<dynamic> cart,
  }) async {
    _loading = true;
    try {
      //await order();
      final result =
          await OrderService().orderDetail(cart: cart);
        NavService.pop();
      if (result == true) {
        _loading = false;
        NavService.pushNamed(RouterPath.bill);
        MessageHepler.showMessage(true, "ອໍເດີສຳເລັດ");
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "ອໍເດີບໍ່ສຳເລັດ $e");
      notifyListeners();
    }
  }
}
