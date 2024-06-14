import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/auth.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/order_list.dart';
import 'package:shop/model/product_list.dart';
import 'package:shop/utils/app_routs.dart';
import 'package:shop/view/pages/auth_or_home_page.dart';
import 'package:shop/view/pages/cart_page.dart';
import 'package:shop/view/pages/orders_page.dart';
import 'package:shop/view/pages/product_detail_page.dart';
import 'package:shop/view/pages/product_form_page.dart';
import 'package:shop/view/pages/products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
            create: (_) => OrderList(),
            update: (ctx, auth, previous) {
              return OrderList(
                auth.token ?? '',
                auth.userId ?? '',
                previous?.items ?? [],
              );
            }),
        ChangeNotifierProvider(
          create: (_) => Cart(),
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
          AppRouts.AUTH_OR_HOME: (context) => const AuthOrHomePage(),
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
