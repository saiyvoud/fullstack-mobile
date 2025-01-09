import 'package:flutter/material.dart';
import 'package:restaurant_app/view/order/widget/order_padding.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: SizedBox(),
        title: Text(
          "ອໍເດີຂອງຂ້ອຍ",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(color: Colors.black),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: [
            Text("ອໍເດີກຳລັງດຳເນີນການ"),
            Text("ອໍເດີສຳເລັດແລ້ວ"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderPadding(),
          Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.indigo),
          ),
        ],
      ),
    );
  }
}
