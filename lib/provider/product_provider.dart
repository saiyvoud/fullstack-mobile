import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/model/product_model.dart';
import 'package:restaurant_app/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  // ການປະກາດຕົວປ່ຽນໃຊ້ພາຍໃນ
  List<ProductModel> _productModel = [];
  bool _loading = false;
  // ສົ່ງຕົວປ່ຽນອອກພາຍນອກ
  List<ProductModel> get productModel => _productModel;
  bool get loading => _loading;

  // ການສ້າງ fucntion
  Future<void> getProduct() async {
    _loading = true;
    try {
      final result = await ProductService().getProduct();
      if (result.length > 0) {
        _productModel = result;
        _loading = false;
        MessageHepler.showMessage(true,"Get Product Success");
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      MessageHepler.showMessage(false,e.toString());
      notifyListeners();
    }
  }
}
