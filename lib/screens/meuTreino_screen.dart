import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';

import 'musclesList_screen.dart';

class TreinoScreen extends StatefulWidget {
  final String treinoId;
  final String title;
  TreinoScreen(this.title, this.treinoId);

  @override
  _TreinoScreenState createState() => _TreinoScreenState(title, treinoId);
}

class _TreinoScreenState extends State<TreinoScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final String treinoId;
  final String title;
  _TreinoScreenState(this.title, this.treinoId);
  final db = FirebaseFirestore.instance;

  Future<void> _deleteAlertDialog(
      BuildContext context, DocumentReference idTreino) async {
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
              'Você tem certeza que deseja apagar esse treino?',
              style: TextStyle(color: Colors.white, fontFamily: "GothamBold"),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.white,
                textColor: Colors.black,
                child: Text(
                  'CANCELAR',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.red,
                textColor: Colors.black,
                child: Text(
                  'APAGAR',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await db.runTransaction((Transaction myTransaction) async {
                    myTransaction.delete(idTreino);
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MuscleListScreen(true, treinoId)));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.grey[700],
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "${title.toUpperCase()}",
            style: TextStyle(fontSize: 25, fontFamily: "GothamBold"),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              splashColor: Colors.black,
              splashRadius: 30,
              iconSize: 25,
              onPressed: () {
                DocumentReference dR = FirebaseFirestore.instance
                    .collection("users")
                    .doc(_auth.currentUser.uid)
                    .collection("planilha")
                    .doc(treinoId);
                _deleteAlertDialog(context, dR);
              },
            )
          ],
        ),
        backgroundColor: Color(0xff313131),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(_auth.currentUser.uid)
              .collection("planilha")
              .doc(treinoId)
              .collection("exercícios")
              .orderBy("pos")
              .get(),
          builder: (context, snapshot) {
            var doc = snapshot.data;
            if (doc == null) return Center(child: CircularProgressIndicator());
            print(doc.docs.length);
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (doc.docs.length <= 0) {
              return Center(
                child: Text(
                  "Nenhum exercício\nadicionado",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "GothamBold",
                      fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return SafeArea(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(5),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(20.0)),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data.docs[index]["title"]
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 23, fontFamily: "GothamBold"),
                                textAlign: TextAlign.center,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              /*Text(snapshot.data.docs[index]["description"],
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: "GothamBook")),*/
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text("Séries",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Gotham")),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(snapshot.data.docs[index]["series"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "GothamBook")),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Repetições",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Gotham")),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(snapshot.data.docs[index]["reps"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "GothamBook")),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Carga",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Gotham")),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                          "${snapshot.data.docs[index]["peso"].toString()}kg",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "GothamBook")),
                                    ],
                                  ),
                                ],
                              ),
                            ],
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
