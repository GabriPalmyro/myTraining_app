import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/tabs/home_tab.dart';
import 'package:tabela_treino/tabs/planilha_tab.dart';
import 'package:tabela_treino/widgets/custom_drawer.dart';
import 'package:tabela_treino/models/user_model.dart';

import 'intro_screen.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  Future<void> _signOutDialog(BuildContext context, UserModel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: Color(0xff313131),
            title: Text(
              'Deseja mesmo sair\nda sua conta?',
              style: TextStyle(
                  color: Colors.white, fontFamily: "GothamThin", fontSize: 25),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.white,
                textColor: Colors.black,
                child: Text(
                  'CANCELAR',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  'SAIR',
                ),
                onPressed: () {
                  Navigator.pop(context);
                  model.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => IntroScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          );
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
              appBar: AppBar(
                title: Text(
                  "Início",
                  style: TextStyle(fontSize: 30, fontFamily: "GothamBold"),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.red,
                    tooltip: 'Log Out',
                    onPressed: () {
                      _signOutDialog(context, model);
                    },
                  ),
                ],
              ),
              body: HomeTab(),
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
}
