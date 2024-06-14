import 'package:flutter/material.dart';
import 'package:shop/utils/app_routs.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Bem vindo User!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRouts.AUTH_OR_HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRouts.ORDERS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Genrenciar Produtos'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRouts.PRODUCTS);
            },
          ),
        ],
      ),
    );
  }
}
