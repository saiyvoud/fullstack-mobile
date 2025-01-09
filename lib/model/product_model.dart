// model ແມ່ນຫຍັງ == > model ແມ່ນບ່ອນເກັບຂໍ້ມູນຊົ່ວຄາວທີ່ເປັນຮູບແບບ object
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));
class ProductModel {
// ແມ່ນການປະກາດຕົວປ່ຽນຮັບຄ່າ
  final String? productID;
  final String? proName_la;
  final String? proDetail_la;
  final int? proQty;
  final int? proPrice;
  final String? image;
// contrature ແມ່ນການເອີ້ນໃຊ້ຕົວປ່ຽນ
  ProductModel({
    this.productID,
    this.proName_la,
    this.proDetail_la,
    this.proQty,
    this.proPrice,
    this.image,
  });
// ປ່ຽນຂໍ້ມູນໃຫ້ເປັນ json ຫລື ເປັນ object
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productID: json['productID'],
        proName_la: json['proName_la'],
        proDetail_la: json['proDetail_la'],
        proQty: int.parse(json['proQty'].toString()),
        proPrice: int.parse(json['proPrice'].toString()),
        image: json['image'],
      );
  // ເປັນການປ່ຽນຂໍ້ມູນຈາກ model ເປັນ json ຄືນ
  Map<String, dynamic> toJson() => {
        "productID": productID,
        "proName_la": proName_la,
        "proDetail_la": proDetail_la,
        "proQty": proQty,
        "proPrice": proPrice,
        "image": image,
      };
}
