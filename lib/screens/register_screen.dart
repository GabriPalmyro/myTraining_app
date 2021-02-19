import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscureTextPass = true;
  bool _obscureTextPassConf = true;

  int sexo = 0;

  // ignore: unused_element
  void _mudarObscure(bool obscureText) {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color colorPrincipal = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            toolbarHeight: 100,
            shadowColor: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(200, 50),
              ),
            ),
            elevation: 25,
            centerTitle: true,
            title: Text(
              "My Training",
              style: TextStyle(
                  color: Colors.grey[850],
                  fontFamily: "GothamBold",
                  fontSize: 30),
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
                    Row(
                      children: [
                        Container(
                          width: 140,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _nameController,
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
                                hintText: "Nome",
                                hintStyle: TextStyle(
                                    color: Colors.grey[300].withOpacity(0.3))),
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty) return "Nome Inválido!";
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          width: 140,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _lastNameController,
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
                                hintText: "Sobrenome",
                                hintStyle: TextStyle(
                                    color: Colors.grey[300].withOpacity(0.3))),
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty) return "Sobrenome Inválido!";
                            },
                          ),
                        ),
                      ],
                    ),
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
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 15,
                        controller: _passConfirmController,
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
                            hintText: "Confirmar Senha",
                            hintStyle: TextStyle(
                                color: Colors.grey[300].withOpacity(0.3))),
                        // ignore: missing_return
                        validator: (text) {
                          if (text.isEmpty ||
                              text.length < 8 ||
                              text != _passController.text)
                            return "Senha não confirmada!";
                        },
                        obscureText: _obscureTextPassConf,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: 120,
                      child: Column(
                        children: [
                          Text(
                            "Gênero",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 30,
                              fontFamily: "GothamLight",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        sexo = 0;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: 130,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: sexo == 0
                                            ? colorPrincipal
                                            : Color(0xff313131),
                                        boxShadow: sexo == 0
                                            ? [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 3,
                                                    blurRadius: 2,
                                                    offset: Offset(0, 4))
                                              ]
                                            : [
                                                BoxShadow(
                                                    color: Colors.transparent)
                                              ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Homem",
                                          style: TextStyle(
                                              color: sexo == 0
                                                  ? Color(0xff313131)
                                                  : colorPrincipal,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        sexo = 1;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: 130,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        boxShadow: sexo == 1
                                            ? [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 3,
                                                    blurRadius: 2,
                                                    offset: Offset(0, 4))
                                              ]
                                            : [
                                                BoxShadow(
                                                    color: Colors.transparent)
                                              ],
                                        color: sexo == 1
                                            ? colorPrincipal
                                            : Color(0xff313131),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Mulher",
                                          style: TextStyle(
                                              color: sexo == 1
                                                  ? Color(0xff313131)
                                                  : colorPrincipal,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "last_name": _lastNameController.text,
                            "email": _emailController.text,
                            "sexo": sexo == 0 ? "Homem" : "Mulher",
                          };
                          model.singUp(
                              userData: userData,
                              pass: _passController.text,
                              onSucess: _onSucess,
                              onFailed: _onFailed);
                        }
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
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: Offset(0, 4))
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ));
          },
        ));
  }

  void _onSucess() {
    // ignore: deprecated_member_use
    print("DEU CERTO");
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        (Route<dynamic> route) => false);
  }

  void _onFailed() {
    // ignore: deprecated_member_use

    print("ERROR");
  }
}
