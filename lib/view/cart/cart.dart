import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/loading.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/provider/order_provider.dart';
import 'package:restaurant_app/provider/product_provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // final products = [
  //   "assets/images/product01.jpeg",
  //   "assets/images/product02.jpg",
  //   "assets/images/product03.jpeg",
  //   "assets/images/product04.webp",
  //   "assets/images/product05.webp",
  //   "assets/images/product06.jpeg",
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text(
            "ລາຍການສິ້ນຄ້າ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Consumer<ProductProvider>(builder: (context, products, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: products.carts.length,
                    itemBuilder: (item, index) {
                      return Column(
                        children: [
                          Container(
                            height: 5,
                            decoration:
                                BoxDecoration(color: Colors.grey.shade100),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      products.carts[index]['image'],
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${products.carts[index]['proName_la']}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${products.carts[index]['proDetail_la']}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${products.carts[index]['proPrice']} LAK",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                              "${products.carts[index]['proQty']} /ຈຳນວນ")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      print("ok");
                                      products.deleteCartOne(index: index);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      );
                    })
              
              ],
            ),
          );
        }),
        bottomNavigationBar:
            Consumer<ProductProvider>(builder: (context, value, child) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "ລາຄາທັງໝົດ:",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${value.totalPrice} LAK",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Consumer<OrderProvider>(builder: (context, order, child) {
                    return GestureDetector(
                      onTap: () {
                        if (value.carts.length > 0) {
                          Loading(context);
                          order.orderDetail(cart: value.carts);
                        }
                        MessageHepler.showMessage(false, 'ຍັງບໍ່ມີຂໍ້ມູນ');
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: value.carts.length > 0 ? Colors.green.shade400 : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "ສັ່ງເລີຍ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }));
  }
}
