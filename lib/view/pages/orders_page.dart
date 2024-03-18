import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/order_list.dart';
import 'package:shop/view/widgets/app_drawer.dart';
import 'package:shop/view/widgets/order_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Meus Pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i])
      ),
      drawer: const AppDrawer(),
    );
  }
}
