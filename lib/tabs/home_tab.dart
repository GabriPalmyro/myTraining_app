import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/screens/musclesList_screen.dart';
import 'package:tabela_treino/screens/token_screen.dart';
import 'package:tabela_treino/tabs/planilha_tab.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
                  child: Column(
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MuscleListScreen()));
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
                )),
          ),
        ],
      );
    });
  }
}
