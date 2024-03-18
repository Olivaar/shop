import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/order_list.dart';
import 'package:shop/model/product_list.dart';
import 'package:shop/utils/app_routs.dart';
import 'package:shop/view/pages/cart_page.dart';
import 'package:shop/view/pages/orders_page.dart';
import 'package:shop/view/pages/product_detail_page.dart';
import 'package:shop/view/pages/product_form_page.dart';
import 'package:shop/view/pages/products_page.dart';
import 'package:shop/view/pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.deepOrange,
          fontFamily: 'Lato',
          useMaterial3: true,
        ),
        // home: ProductOverviewPage(),
        routes: {
          AppRouts.HOME: (context) => ProductOverviewPage(),
          AppRouts.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          AppRouts.CART: (context) => const CartPage(),
          AppRouts.ORDERS: (context) => const OrdersPage(),
          AppRouts.PRODUCTS: (context) => const ProductsPage(),
          AppRouts.PRODUCT_FORM: (context) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


