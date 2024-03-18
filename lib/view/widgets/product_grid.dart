import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/view/widgets/product_grid_item.dart';
import '../../model/product.dart';
import '../../model/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool shoFavoriteOnly;

  const ProductGrid(
    this.shoFavoriteOnly, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadProducts =
        shoFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: loadProducts[i],
        child: ProductGridItem(),
      ),
    );
  }
}
