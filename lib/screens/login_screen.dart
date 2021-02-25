import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/screens/register_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscureTextPass = true;

  @override
  Widget build(BuildContext context) {
    final Color colorPrincipal = Theme.of(context).primaryColor;

    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: AppBar(
            toolbarHeight: 120,
            shadowColor: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(300, 50),
              ),
            ),
            elevation: 25,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.png',
                  height: 100,
                ),
                Text(
                  "Treine Fácil!",
                  style: TextStyle(
                      color: Colors.grey[850],
                      fontFamily: "GothamBold",
                      fontSize: 30),
                ),
              ],
            ),
            backgroundColor: colorPrincipal,
          ),
        ),
        backgroundColor: Color(0xff313131),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.only(top: 40.0, left: 40, right: 40),
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        style: TextStyle(color: colorPrincipal),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[400].withOpacity(0.2)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: colorPrincipal.withOpacity(0.6)),
                            ),
                            hintText: "E-mail",
                            hintStyle: TextStyle(
                                color: Colors.grey[300].withOpacity(0.3))),
                        // ignore: missing_return
                        validator: (text) {
                          if (text.isEmpty || !text.contains("@"))
                            return "E-mail Inválido!";
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 15,
                        controller: _passController,
                        style: TextStyle(color: colorPrincipal),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[400].withOpacity(0.2)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: colorPrincipal.withOpacity(0.6)),
                            ),
                            hintText: "Senha",
                            hintStyle: TextStyle(
                                color: Colors.grey[300].withOpacity(0.3))),
                        // ignore: missing_return
                        validator: (text) {
                          if (text.isEmpty || text.length < 8)
                            return "Senha Inválido!";
                        },
                        obscureText: _obscureTextPass,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty)
                            // ignore: deprecated_member_use
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content:
                                  Text("Insira seu e-mail para recuperação!"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ));
                          else {
                            // ignore: deprecated_member_use
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Confira seu e-mail!"),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: colorPrincipal.withOpacity(0.7),
                              fontFamily: "GothamLight"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {}
                        model.signIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSucess: _onSucess,
                            onFailed: _onFailed);

                        //container animation
                      },
                      child: Container(
                        width: 230,
                        height: 60,
                        child: Center(
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
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
                    SizedBox(
                      height: 80,
                    ),
                    Column(
                      children: [
                        Text(
                          "Não tem cadastro?",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "GothamLight",
                              fontSize: 15),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            "Registre-se",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: "GothamBold",
                                fontSize: 30),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "É Personal? Entre como Personal aqui!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "GothamLight",
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 150,
                            height: 60,
                            child: Center(
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage("images/google_logo.png"),
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("ñ funciona")
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
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
                    )
                  ],
                ));
          },
        ));
  }

  void _onSucess() {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Vamos lá!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
    ));
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        (Route<dynamic> route) => false);
  }

  void _onFailed() {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content:
          Text("Erro ao entrar, verifique seu email ou sua senha novamente"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
