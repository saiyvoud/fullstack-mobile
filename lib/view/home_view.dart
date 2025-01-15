import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/formatNumber.dart';

import 'package:restaurant_app/provider/product_provider.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/view/cart/cart.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        leading: Center(child: Text("Welcome",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
        leadingWidth: 100,
        centerTitle: true,
        // leading: Container(
        //   height: 50,
        //   width: 50,
        //   //decoration: BoxDecoration(color: Colors.red),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: SvgPicture.asset(
        //       "assets/icons/category.svg",
        //       color: Colors.red,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        actions: [
          Consumer<ProductProvider>(
            builder: (context,cart,child) {
              return Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            "${cart.carts.length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CartView(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer<ProductProvider>(builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  value.deleteCartAll();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(60)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      "assets/icons/man.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Search Shose",
                            suffixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sport Shose",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "view all",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              value.loading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: value.productModel.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final data = value.productModel;
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  height: 200,
                                  width: double.infinity,
                                  data[index].image.toString(),
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child:
                                      Text(data[index].proName_la.toString()),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child:
                                      Text(data[index].proDetail_la.toString()),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${FormatNumber.numberFormate(data[index].proPrice)} ກີບ",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            value.updateCart(
                                              data: data[index],
                                              index: index,
                                              amount: 1,
                                              proQty: data[index].proQty!,
                                            );
                                            // if (value.carts.isNotEmpty) {
                                            //   if (value.carts[index]
                                            //           ['productID'] ==
                                            //       value.productModel[index]
                                            //           .productID) {
                                            //     value.updateCart(
                                            //       data: data[index],
                                            //       index: index,
                                            //       amount: 1,
                                            //       proQty: data[index].proQty!,
                                            //     );
                                            //     print("====>update ");
                                            //   } else {
                                            //     value.addCart(
                                            //         data: data[index]);
                                            //     print("====>add ");
                                            //   }
                                            // } else {
                                            //   value.addCart(data: data[index]);
                                            //   print("====>add ");
                                            // }
                                          },
                                          icon: Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.green,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
            ],
          ),
        );
      }),
    );
  }
}
