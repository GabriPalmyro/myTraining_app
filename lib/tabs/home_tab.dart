import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/screens/intro_screen.dart';
import 'package:tabela_treino/screens/musclesList_screen.dart';
import 'package:tabela_treino/screens/token_screen.dart';
import 'package:tabela_treino/tabs/planilha_tab.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
              TextButton(
                child: Text(
                  'CANCELAR',
                  style: TextStyle(color: Colors.white),
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
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.userData["name"] == null)
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      return ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olá, ${model.userData["name"]}",
                            style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 33,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "Vamos treinar?",
                            style: TextStyle(
                                fontFamily: "GothamThin",
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      IconButton(
                        alignment: Alignment.topRight,
                        icon: const Icon(Icons.logout),
                        color: Colors.red,
                        tooltip: 'Log Out',
                        onPressed: () {
                          _signOutDialog(context, model);
                        },
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlanilhaScreen()));
            },
            child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.only(top: 15, left: 20),
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(2, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Seus Treinos",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontFamily: "GothamBold",
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Acompanhe e edite\nsuas planilhas de treinos\nsemanais!",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontFamily: "Gotham",
                          fontStyle: FontStyle.italic,
                          fontSize: 20),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MuscleListScreen(false, null)));
            },
            child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.only(top: 15, left: 20),
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(2, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Veja os exercícios",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontFamily: "GothamBold",
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Vejo os musculos!",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontFamily: "Gotham",
                          fontStyle: FontStyle.italic,
                          fontSize: 20),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TokenScreen()));
            },
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(top: 15, left: 20),
              height: 130,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(2, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Token de acesso\npara personal trainer",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: "GothamBold",
                        fontStyle: FontStyle.italic,
                        fontSize: 26),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Envie um token de segurança para\nque ele tenha acesso aos\nseus treinos por tempo limitado",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: "Gotham",
                        fontStyle: FontStyle.italic,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
    });
  }
}
