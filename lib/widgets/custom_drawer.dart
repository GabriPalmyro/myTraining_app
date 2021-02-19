import 'package:flutter/material.dart';
import 'package:tabela_treino/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerTile(Icons.home, "Início", pageController, 0),
          DrawerTile(Icons.list, "Planilhas", pageController, 1),
        ],
      ),
    );
  }
}
