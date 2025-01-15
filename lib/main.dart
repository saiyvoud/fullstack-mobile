import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nav_service/nav_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/bottomNavigator_widget.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/provider/auth_provider.dart';
import 'package:restaurant_app/provider/order_provider.dart';
import 'package:restaurant_app/provider/product_provider.dart';
import 'package:restaurant_app/router/router.dart';
import 'package:restaurant_app/view/home_view.dart';

import 'package:restaurant_app/view/cart/bill_view.dart';
import 'package:restaurant_app/view/tester_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Open the box with a specific type during initialization
  // await Hive.openBox<Map<String, dynamic>>('cart');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductProvider()
              ..getProduct()
              ..getCart()),
        ChangeNotifierProvider(
          create: (_) => OrderProvider()
            ..getOrderByStatusPadding()
            ..getOrderByStatusSuccess(),
        ),
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
      onGenerateRoute: RouterPath.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavService.navigatorKey,
      initialRoute: RouterPath.home,
      //home: BillView(),
    );
  }
}
