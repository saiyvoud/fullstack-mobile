import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TesterView extends StatefulWidget {
  const TesterView({super.key});

  @override
  State<TesterView> createState() => _TesterViewState();
}

class _TesterViewState extends State<TesterView> {
  // Scaffold ແມ່ນຫຍັງ ? ແມ່ນ widget ທີ່ໃຊ້ເປັນ backgroud ໃຫ້ກັບ ການອອກແບບແອັບ
  // ສ່ວນປະກອບຂອງ scaffold ປະກອບມີຫຍັງແດ່?
  // 1 AppBar 2 body 3 bottomNavigator , 4 floatingActionButton 5 Drawer
  // 1 AppBar ປະກອບມີ 3 ສ່ວນ 1 leading 2 title 3 action
  // 2 Body ແມ່ນສ່ວນກາງຂອງແອັບ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Tester View",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(
            Icons.person,
            color: Colors.green,
          ),
          Icon(
            Icons.person,
            color: Colors.green,
          ),
          Icon(
            Icons.person,
            color: Colors.green,
          ),
          Icon(
            Icons.person,
            color: Colors.green,
          ),
        ],
      ),
      body: Center(
        child: Text("Welcome to Midi Technology"),
      ),
      bottomNavigationBar: Container(
        height: 120,
        color: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
      ),
      drawer: Drawer(
        
      ) ,
    );
  }
}
