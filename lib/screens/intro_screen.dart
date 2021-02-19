import 'package:flutter/material.dart';
import 'package:tabela_treino/screens/register_screen.dart';
import 'login_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            toolbarHeight: 120,
            shadowColor: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(200, 50),
              ),
            ),
            elevation: 25,
            centerTitle: true,
            title: Text(
              "Bem-Vindo",
              style: TextStyle(
                  color: Colors.grey[850],
                  fontFamily: "GothamBold",
                  fontSize: 30),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Color(0xff313131),
        body: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    child: Container(
                      width: 230,
                      height: 60,
                      child: Center(
                        child: Text(
                          "Registre-se",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 2,
                                offset: Offset(0, 4))
                          ]),
                    ),
                  ),
                  SizedBox(height: 100),
                  Text(
                    "Já tem cadastro?",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "GothamLight",
                        fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Faça o Login",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: "GothamBold",
                          fontSize: 35),
                    ),
                  ),
                  SizedBox(height: 100),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      height: 60,
                      child: Center(
                        child: Image(
                          image: AssetImage("images/google_logo.png"),
                          height: 40,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: Offset(0, 4))
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
