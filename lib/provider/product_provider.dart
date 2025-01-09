import 'package:flutter/cupertino.dart';
import 'package:nav_service/nav_service.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/model/product_model.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  // ການປະກາດຕົວປ່ຽນໃຊ້ພາຍໃນ
  List<ProductModel> _productModel = [];
  List<dynamic> _carts = [];
  int _totalPrice = 0;
  int _total = 0;
  bool _loading = false;
  // ສົ່ງຕົວປ່ຽນອອກພາຍນອກ
  List<ProductModel> get productModel => _productModel;
  List<dynamic> get carts => _carts;
  int get totalPrice => _totalPrice;
  bool get loading => _loading;

  Future<void> deleteCartOne({
    required int index,
  }) async {
    _loading = true;
    try {
      final result = await ProductService().deleteCartOne(index: index);
      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "ລົບສິນຄ້າສຳເລັດ");
        getCart();
        notifyListeners();
      } else {
        _loading = false;
        MessageHepler.showMessage(false, result.toString());
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "Faild");
      notifyListeners();
    }
  }

  Future<void> goToHome() async {
    try {
      await deleteCartAll();
      
      NavService.pushNamedAndRemoveUntil(RouterPath.home);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCartAll() async {
    _loading = true;
    try {
      final result = await ProductService().deleteCartAll();
      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "ລົບສິນຄ້າທັງໝົດສຳເລັດ");
        getCart();
        notifyListeners();
      } else {
        _loading = false;
        MessageHepler.showMessage(false, result.toString());
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "Faild");
      notifyListeners();
    }
  }

  Future<void> getCart() async {
    _loading = true;
    try {
      final result = await ProductService().getCart();
      _total = 0;
      _totalPrice = 0;
      if (result != null) {
        _loading = false;
        _carts = result;

        for (var i = 0; i < result.length; i++) {
          _total += int.parse(result[i]['proPrice'].toString()) *
              int.parse(result[i]['proQty'].toString());
        }
        _totalPrice = _total;

        MessageHepler.showMessage(true, "Get Cart Success");
        notifyListeners();
      } else {
        _loading = false;

        MessageHepler.showMessage(false, "Get Cart Faild");
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      //MessageHepler.showMessage(false, e.toString());
      notifyListeners();
    }
  }

  Future<void> addCart({
    required ProductModel data,
  }) async {
    _loading = true;
    try {
      final result = await ProductService().addCart(data: data);
      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "ເພີ່ມສິນຄ້າສຳເລັດ");
        getCart();
        notifyListeners();
      } else {
        _loading = false;
        MessageHepler.showMessage(false, result.toString());
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "Faild");
      notifyListeners();
    }
  }

  Future<void> updateCart({
    required ProductModel data,
    required int index,
    required int amount,
    required int proQty,
  }) async {
    _loading = true;
    try {
      final result = await ProductService().updateCart(
        data: data,
        index: index,
        amount: amount,
        proQty: proQty,
      );

      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "ເພີ່ມສິນຄ້າສຳເລັດ");
        getCart();
        notifyListeners();
      } else {
        _loading = false;
        MessageHepler.showMessage(false, result.toString());
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, "Faild");
      notifyListeners();
    }
  }

  Future<void> CheckQRCode({
    required String tableID,
  }) async {
    _loading = true;
    try {
      final result = await ProductService().CheckQRCode(tableID: tableID);
      if (result == true) {
        _loading = false;
        MessageHepler.showMessage(true, "Success");
        NavService.pushReplacementNamed(RouterPath.product);
        notifyListeners();
      }
    } catch (e) {
      NavService.pop();
      _loading = false;
      MessageHepler.showMessage(false, "Faild");
      notifyListeners();
    }
  }

  // ການສ້າງ fucntion
  Future<void> getProduct() async {
    _loading = true;
    try {
      final result = await ProductService().getProduct();
      if (result!.length > 0) {
        _productModel = result;
        _loading = false;
        //MessageHepler.showMessage(true, "Get Product Success");
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false, e.toString());
      notifyListeners();
    }
  }
}
