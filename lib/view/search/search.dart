import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nav_service/nav_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/formatNumber.dart';
import 'package:restaurant_app/components/loading.dart';

import 'package:restaurant_app/provider/product_provider.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/view/cart/cart.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
     
      body: Consumer<ProductProvider>(builder: (context, value, child) {
        if (value.loading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
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
                      child: TextFormField(
                        controller: search,
                        decoration: InputDecoration(
                            hintText: "Search Shose",
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  Loading(context);
                                  value.search(search: search.text);
                                },
                                child: Icon(Icons.search)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () async {
                          Loading(context);
                          value.getProduct();
                          await Future.delayed(Duration(seconds: 2));
                          NavService.pop();
                        },
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
