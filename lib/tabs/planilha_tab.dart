import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tabela_treino/screens/meuTreino_screen.dart';

class PlanilhaScreen extends StatefulWidget {
  @override
  _PlanilhaScreenState createState() => _PlanilhaScreenState();
}

class _PlanilhaScreenState extends State<PlanilhaScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _titleController = TextEditingController();
  final _descriController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
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
              'Crie um novo treino!',
              style: TextStyle(color: Colors.white, fontFamily: "GothamBold"),
            ),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
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
                        hintText: "Título do treino",
                        hintStyle: TextStyle(
                            color: Colors.grey[300].withOpacity(0.3))),
                    controller: _titleController,
                  ),
                  TextField(
                    maxLength: 50,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    maxLines: 2,
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
                      hintText: "Descrição do treino",
                      hintStyle:
                          TextStyle(color: Colors.grey[300].withOpacity(0.3)),
                    ),
                    controller: _descriController,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  'CANCELAR',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _titleController.text = "";
                    _descriController.text = "";
                    Navigator.pop(context);
                  });
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  'CRIAR',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _createNew(
                        title: _titleController.text,
                        description: _descriController.text);
                    _titleController.text = "";
                    _descriController.text = "";
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<Null> _createNew(
      {@required String title, @required String description}) async {
    setState(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .collection("planilha")
          .add({"title": title, "description": description}).then((_) {
        print("Treino criada com sucesso");
      }).catchError((_) {
        print("Ocorreu um erro");
      });
    });
  }

  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        floatingActionButton: Container(
          height: 80.0,
          width: 60.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _displayTextInputDialog(context);
                });
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.grey[700],
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Minha planilha de treino",
            style: TextStyle(fontSize: 20, fontFamily: "GothamBold"),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xff313131),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(_auth.currentUser.uid)
              .collection("planilha")
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              return SafeArea(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(5),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print("${snapshot.data.docs[index].id}");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TreinoScreen(
                                  snapshot.data.docs[index]["title"],
                                  snapshot.data.docs[index].id)));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(30.0)),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(2, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data.docs[index]["title"]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 25, fontFamily: "GothamBold"),
                                  textAlign: TextAlign.center,
                                ),
                                Divider(),
                                Text(
                                  snapshot.data.docs[index]["description"],
                                  style: TextStyle(
                                      fontSize: 22, fontFamily: "GothamBook"),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          },
        ),
      );
    });
  }
}
