import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/tabs/home_tab.dart';
import 'package:tabela_treino/tabs/planilha_tab.dart';
import 'package:tabela_treino/widgets/custom_drawer.dart';
import 'package:tabela_treino/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;
  final List<Widget> _screens = [HomeTab(), PlanilhaScreen(), PlanilhaScreen()];

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
              /*bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                unselectedItemColor: Color(0xff313131),
                iconSize: 30,
                onTap: onTabTapped,
                currentIndex: 0,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: "Planilhas"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Perfil"),
                ],
              ),*/
              body: _screens[_currentIndex],
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(
                  "Sua planilha",
                  style: TextStyle(fontSize: 30, fontFamily: "GothamBold"),
                ),
                centerTitle: true,
              ),
              drawer: CustomDrawer(_pageController),
              body: PlanilhaScreen(),
            ),
          ],
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
