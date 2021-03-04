import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/tabs/home_tab.dart';
import 'package:tabela_treino/tabs/planilha_tab.dart';
import 'package:tabela_treino/tabs/profile_tab.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/ads/ads_model.dart';
import 'package:tabela_treino/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;
  final List<Widget> _screens = [HomeTab(), PlanilhaScreen(), ProfileTab()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Scaffold(
              backgroundColor: Color(0xff313131),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
              ),
              drawer: CustomDrawer(),
              appBar: AppBar(
                toolbarHeight: 70,
                shadowColor: Colors.grey[850],
                elevation: 25,
                centerTitle: true,
                title: Text(
                  "Treino Fácil",
                  style: TextStyle(
                      color: Colors.grey[850],
                      fontFamily: "GothamBold",
                      fontSize: 30),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: _screens[_currentIndex],
            ),
          ],
        );
      },
    );
  }
}
