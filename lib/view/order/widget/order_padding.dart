import 'package:flutter/material.dart';
import 'package:nav_service/nav_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/order_provider.dart';
import 'package:restaurant_app/view/cart/bill_view.dart';
import 'package:restaurant_app/view/order/widget/bill_order.dart';

class OrderPadding extends StatefulWidget {
  const OrderPadding({super.key});

  @override
  State<OrderPadding> createState() => _OrderPaddingState();
}

class _OrderPaddingState extends State<OrderPadding> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, order, child) {
      return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: order.orderDataPadding.length,
          itemBuilder: (item, index) {
            final data = order.orderDataPadding;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BillOrder(
                            orderID: data[index]['orderID'],
                          )),
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/check.png",
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ສັ່ງອໍເດີ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${data[index]['username']}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "ໂຕະເບີ: ${data[index]['tableName']}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${data[index]['phoneNumber']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Text("19-01-2025",
                                style: TextStyle(fontSize: 11)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
