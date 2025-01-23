import 'package:flutter/material.dart';
import 'package:nav_service/nav_service.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  bool _loading = false;
  List<dynamic> _orders = [];
  List<dynamic> _orderDataPadding = [];
  List<dynamic> _orderDataSuccess = [];
  int _totalPrice = 0;
  int _total = 0;
  // ສົ່ງຕົວປ່ຽນອອກພາຍນອກ
  bool get loading => _loading;
  int get totalPrice => _totalPrice;
  List<dynamic> get orders => _orders;
  List<dynamic> get orderDataPadding => _orderDataPadding;
  List<dynamic> get orderDataSuccess => _orderDataSuccess;
  

  Future<void> updateStatus({
    required String orderID,
    required String paymentType,
    required String priceTotal,
  }) async {
    _loading = true;
    try {
      final result = await OrderService().updateStatus(
        orderID: orderID,
        paymentType: paymentType,
        priceTotal: priceTotal,
      );
      NavService.pop();
      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "update Success");
       await getOrderByStatusPadding();
       await getOrderByStatusSuccess();
        NavService.pushReplacementNamed(RouterPath.bottom);
        notifyListeners();
      } else {
        MessageHepler.showMessage(false, "Order Faild");
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "ອໍເດີບໍ່ສຳເລັດ $e");
      notifyListeners();
    }
  }

  Future<void> getOrderByStatusPadding() async {
    _loading = true;
    try {
      final result = await OrderService().getOrderByStatus(status: '0');

      if (result != null) {
        _orderDataPadding = result;
        print(_orders);
        _loading = false;
        notifyListeners();
      } else {
        // MessageHepler.showMessage(false, "Order Faild");
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "ອໍເດີບໍ່ສຳເລັດ $e");
      notifyListeners();
    }
  }

  Future<void> getOrderByStatusSuccess() async {
    _loading = true;
    try {
      final result = await OrderService().getOrderByStatus(status: '1');

      if (result != null) {
        _orderDataSuccess = result;
        print(_orders);
        _loading = false;
        
        notifyListeners();
      } else {
      //  MessageHepler.showMessage(false, "Order Faild");
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "ອໍເດີບໍ່ສຳເລັດ $e");
      notifyListeners();
    }
  }

  Future<void> getOrderDetailBy({
    required String orderID,
  }) async {
    _loading = true;
    try {
      final result = await OrderService().getOrderDetailBy(orderID: orderID);

      if (result != null) {
        _orders = result;
         for (var i = 0; i < result.length; i++) {
          _total += int.parse(result[i]['proPrice'].toString()) *
              int.parse(result[i]['proQty'].toString());
        }
        _totalPrice = _total;
        print(_orders);
        //MessageHepler.showMessage(true, "ອໍເດີສຳເລັດ");
        _loading = false;
        notifyListeners();
      } else {
       // MessageHepler.showMessage(false, "Order Faild");
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "ອໍເດີບໍ່ສຳເລັດ $e");
      notifyListeners();
    }
  }

  Future<void> order() async {
    _loading = true;
    try {
      final result = await OrderService().order();
      NavService.pop();
      if (result == true) {
        _loading = false;
       // MessageHepler.showMessage(true, "ອໍເດີສຳເລັດ");
        notifyListeners();
      } else {
      //  MessageHepler.showMessage(false, "Order Faild");
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
      await OrderService().order();
      final result = await OrderService().orderDetail(cart: cart);
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
