import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  //text controllers
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  //authUser

  FirebaseAuth _auth = FirebaseAuth.instance;

  //keys
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.userData["name"] == null)
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      _nameController.text = model.userData["name"];
      _lastNameController.text = model.userData["last_name"];
      _emailController.text = model.userData["email"];
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 70,
          shadowColor: Colors.grey[850],
          elevation: 25,
          centerTitle: true,
          title: Text(
            "Editar Perfil",
            style: TextStyle(
                color: Colors.grey[850],
                fontFamily: "GothamBold",
                fontSize: 30),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Color(0xff313131),
        body: Form(
            key: _formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 80, left: 40, right: 40),
              children: [
                Container(
                  height: 130,
                  width: 120,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("images/blank-profile-picture.png")),
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
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      width: 140,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        maxLength: 15,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[400].withOpacity(0.2)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.6)),
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
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      width: 140,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _lastNameController,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        maxLength: 20,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[400].withOpacity(0.2)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.6)),
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
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[400].withOpacity(0.2)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6)),
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
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.validate()) {}

                    //CONFIRMAÇÃO E FUNÇÃO DE SALVAR NOVOS ATUALIZAÇÃO DE PERFIL
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    height: 60,
                    child: Center(
                      child: Text(
                        "Confirmar",
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
              ],
            )),
      );
    });
  }
}
