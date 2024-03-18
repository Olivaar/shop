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
            title: Text('Bem vindo User!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRouts.HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRouts.ORDERS);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Genrenciar Produtos'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRouts.PRODUCTS);
            },
          ),
        ],
      ),
    );
  }
}
