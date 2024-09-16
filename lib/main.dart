import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/bottomNavigator_widget.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/provider/product_provider.dart';
import 'package:restaurant_app/view/home_view.dart';
import 'package:restaurant_app/view/tester_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()..getProduct()),
      ],
      child: MyApp(),
    ),
  );
}

// ----- state less ແມ່ນ widget ທີ່ໃຊ້ໄວ້ສະແດງຂໍ້ມູນຄົງທີ່ບໍ່ປ່ຽນແປງຫລາຍຄັ້ງ stl
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: MessageHepler.scaffoldMessengerKey,
      home: BottomNavigatorWidget(),
    );
  }
}
