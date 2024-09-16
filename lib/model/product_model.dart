// model ແມ່ນຫຍັງ == > model ແມ່ນບ່ອນເກັບຂໍ້ມູນຊົ່ວຄາວທີ່ເປັນຮູບແບບ object
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));
class ProductModel {
// ແມ່ນການປະກາດຕົວປ່ຽນຮັບຄ່າ
  final String? productId;
  final String? name;
  final String? detail;
  final int? amount;
  final int? price;
  final String? image;
// contrature ແມ່ນການເອີ້ນໃຊ້ຕົວປ່ຽນ
  ProductModel({
    this.productId,
    this.name,
    this.detail,
    this.amount,
    this.price,
    this.image,
  });
// ປ່ຽນຂໍ້ມູນໃຫ້ເປັນ json ຫລື ເປັນ object
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productId: json['productId'],
        name: json['name'],
        detail: json['detail'],
        amount: int.parse(json['amount'].toString()),
        price: int.parse(json['price'].toString()),
        image: json['image'],
      );
  // ເປັນການປ່ຽນຂໍ້ມູນຈາກ model ເປັນ json ຄືນ
  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "detail": detail,
        "amount": amount,
        "price": price,
        "image": image,
      };
}
