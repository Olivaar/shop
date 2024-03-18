import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/product_list.dart';
import 'package:shop/utils/app_routs.dart';
import 'package:shop/view/widgets/app_drawer.dart';
import 'package:shop/view/widgets/product_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouts.PRODUCT_FORM);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(
                product: products.items[i],
              ),
              const Divider(),
            ],
          ),
          itemCount: products.itemsCount,
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
