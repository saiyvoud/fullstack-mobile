import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/view/home_view.dart';

class BottomNavigatorWidget extends StatefulWidget {
  const BottomNavigatorWidget({super.key});

  @override
  State<BottomNavigatorWidget> createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  int currentIndex = 0;
  List<Widget> _children = [
    HomeView(),
    Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
    ),
    Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.pink,
      ),
    ),
    Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    ),
    Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.purple,
      ),
    ),
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "ຫນ້າຫຼັກ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "ຄົ້ນຫາ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "ອໍເດີ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: "ແຈ້ງເຕືອນ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "ໂປຣໄຟຣ",
          ),
        ],
      ),
    );
  }
}
