import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/components/barcodesimple.dart';
import 'package:restaurant_app/view/home_view.dart';
import 'package:restaurant_app/view/order/myOrder.dart';
import 'package:restaurant_app/view/profile/profile.dart';
import 'package:restaurant_app/view/qrcode/qrcode_view.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:restaurant_app/view/search/search.dart';

class BottomNavigatorWidget extends StatefulWidget {
  const BottomNavigatorWidget({super.key});

  @override
  State<BottomNavigatorWidget> createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  int currentIndex = 0;
  List<Widget> _children = [
    HomeView(),
    // QRCodeView(),
    SearchView(),

    MyOrder(),
    ProfileView(),
  ];
  _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      floatingActionButton: Container(
        height: 45,
        width: 45,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => BarcodeScannerSimple()));
          },
          child: Icon(Icons.qr_code_scanner),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.redAccent,
        height: 60,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                _onTap(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                _onTap(1);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.print,
                color: Colors.white,
              ),
              onPressed: () {
                _onTap(2);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              onPressed: () {
                _onTap(3);
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(

      //   backgroundColor: Colors.white,
      //   onTap: _onTap,
      //   currentIndex: currentIndex,
      //   selectedItemColor: Colors.red,
      //   unselectedItemColor: Colors.grey,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "ຫນ້າຫຼັກ",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: "ຄົ້ນຫາ",
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.shopping_bag),
      //     //   label: "ອໍເດີ",
      //     // ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notification_add),
      //       label: "ແຈ້ງເຕືອນ",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: "ໂປຣໄຟຣ",
      //     ),
      //   ],
      // ),
    );
  }
}
