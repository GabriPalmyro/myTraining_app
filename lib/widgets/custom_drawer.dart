import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/screens/musclesList_screen.dart';
import 'package:tabela_treino/tabs/home_tab.dart';
import 'package:tabela_treino/tabs/planilha_tab.dart';
import 'package:tabela_treino/tabs/profile_tab.dart';
import 'package:tabela_treino/transition/transitions.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child:
        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.grey[900],
        child: ListView(shrinkWrap: true, children: [
          Container(
            child: DrawerHeader(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage("images/blank-profile-picture.png")),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${model.userData["name"].toString().toUpperCase()} ${model.userData["last_name"].toString().toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "GothamBook",
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeTab()));
                    print("home");
                  },
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 32),
                        Text(
                          "Página inicial",
                          style: TextStyle(
                            fontFamily: "GothamThin",
                            fontSize: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => PlanilhaScreen()));
                    print("planilhas");
                  },
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.list_outlined,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 32),
                        Text(
                          "Sua Planilha\nde Treino",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "GothamThin",
                            fontSize: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, SlideLeftRoute(page: ProfileTab()));
                    print("perfil");
                  },
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 32),
                        Text(
                          "Seu Perfil",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "GothamThin",
                            fontSize: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MuscleListScreen(false, null)));
                    print("musculos");
                  },
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.line_weight,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 32),
                        Text(
                          "Lista de\nexercícios",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "GothamThin",
                            fontSize: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
        ]),
      );
    }));
  }
}
