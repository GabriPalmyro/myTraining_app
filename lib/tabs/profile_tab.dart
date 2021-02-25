import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/screens/intro_screen.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
      return Scaffold(
          backgroundColor: Color(0xff313131),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 60,
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .6,
                  decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 65),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${model.userData["name"]} ${model.userData["last_name"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "GothamBook",
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.userData["email"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "GothamBook",
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  letterSpacing: 2),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        height: 0,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Minha Conta",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    fontSize: 20,
                                    color: Colors.grey[850].withOpacity(0.8)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey[700].withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Configurações de treino",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    fontSize: 20,
                                    color: Colors.grey[850].withOpacity(0.8)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey[700].withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Compartilhar o App",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    fontSize: 20,
                                    color: Colors.grey[850].withOpacity(0.8)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey[700].withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Avaliar o App",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    fontSize: 20,
                                    color: Colors.grey[850].withOpacity(0.8)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey[700].withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Informações Úteis",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    fontSize: 20,
                                    color: Colors.grey[850].withOpacity(0.8)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey[700].withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 15,
                  right: MediaQuery.of(context).size.width / 2.7,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage("images/blank-profile-picture.png")),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  top: 80,
                  right: MediaQuery.of(context).size.width / 1.25,
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      splashRadius: 20,
                      splashColor: Colors.yellow,
                      onPressed: () {})),
              Positioned(
                  top: 80,
                  right: MediaQuery.of(context).size.width / 13,
                  child: IconButton(
                      icon: Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.red.withOpacity(0.5),
                      ),
                      splashRadius: 20,
                      splashColor: Colors.red,
                      onPressed: () {
                        _signOutDialog(context, model);
                      })),
            ],
          ));
    });
  }
}
