import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';

class MuscleScreen extends StatefulWidget {
  final String treinoId;
  final String title;
  final bool addMode;
  MuscleScreen(this.title, this.addMode, this.treinoId);

  @override
  _MuscleScreenState createState() =>
      _MuscleScreenState(title, addMode, treinoId);
}

class _MuscleScreenState extends State<MuscleScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final String title;
  final bool addMode;
  final String treinoId;
  _MuscleScreenState(this.title, this.addMode, this.treinoId);

  Color _color1 = Color(0xfffcd103);
  Color _color2 = Color(0xFFffdb30);
  Color _color3 = Color(0xffffe87a);

  int _series = 4;
  int _reps = 12;
  int _carga = 25;

  // ignore: deprecated_member_use
  Future<void> _displayModalBottom(BuildContext context, QuerySnapshot doc,
      UserModel model, int index) async {
    return showModalBottomSheet(
        backgroundColor: Colors.grey[850],
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Container(
                color: Colors.grey[850],
                height: 1000,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        "${doc.docs[index]["title"]}: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Gotham",
                            fontSize: 25),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Séries",
                        style: TextStyle(
                            color: _color1,
                            fontFamily: "GothamBook",
                            fontSize: 20),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                              minWidth: 5,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                setState(() {
                                  _series = _series - 10;
                                });
                              },
                              child: Text("-10")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color2,
                              onPressed: () {
                                setState(() {
                                  _series = _series - 5;
                                });
                              },
                              child: Text("-5")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color3,
                              onPressed: () {
                                setState(() {
                                  _series = _series - 1;
                                });
                              },
                              child: Text("-1")),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$_series",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontFamily: "GothamBold"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: Color(0xffffe87a),
                              onPressed: () {
                                setState(() {
                                  _series = _series + 1;
                                });
                              },
                              child: Text("+1")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: Color(0xFFffdb30),
                              onPressed: () {
                                setState(() {
                                  _series = _series + 5;
                                });
                              },
                              child: Text("+5")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                setState(() {
                                  _series = _series + 10;
                                });
                              },
                              child: Text("+10")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Repetições",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: "GothamBook",
                            fontSize: 20),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlatButton(
                              minWidth: 5,
                              color: _color1,
                              onPressed: () {
                                setState(() {
                                  _reps = _reps - 10;
                                });
                              },
                              child: Text("-10")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color2,
                              onPressed: () {
                                setState(() {
                                  _reps = _reps - 5;
                                });
                              },
                              child: Text("-5")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color3,
                              onPressed: () {
                                setState(() {
                                  _reps = _reps - 1;
                                });
                              },
                              child: Text("-1")),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$_reps",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontFamily: "GothamBold"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color3,
                              onPressed: () {
                                setState(() {
                                  _reps = _reps + 1;
                                });
                              },
                              child: Text("+1")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color2,
                              onPressed: () {
                                setState(() {
                                  _reps = _reps + 5;
                                });
                              },
                              child: Text("+5")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color1,
                              onPressed: () {
                                setState(() {
                                  _reps = _reps + 10;
                                });
                              },
                              child: Text("+10")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Carga",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: "GothamBook",
                            fontSize: 20),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlatButton(
                              minWidth: 5,
                              color: _color1,
                              onPressed: () {
                                setState(() {
                                  _carga = _carga - 10;
                                });
                              },
                              child: Text("-10")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color2,
                              onPressed: () {
                                setState(() {
                                  _carga = _carga - 5;
                                });
                              },
                              child: Text("-5")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color3,
                              onPressed: () {
                                setState(() {
                                  _carga = _carga - 1;
                                });
                              },
                              child: Text("-1")),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$_carga",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontFamily: "GothamBold"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color3,
                              onPressed: () {
                                setState(() {
                                  _carga = _carga + 1;
                                });
                              },
                              child: Text("+1")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color2,
                              onPressed: () {
                                setState(() {
                                  _carga = _carga + 5;
                                });
                              },
                              child: Text("+5")),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                              minWidth: 5,
                              color: _color1,
                              onPressed: () {
                                setState(() {
                                  _carga = _carga + 10;
                                });
                              },
                              child: Text("+10")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // ignore: deprecated_member_use
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.white.withOpacity(0.5);
                              return null; // Use the component's default.
                            },
                          )),
                          child: Text(
                            'CANCELAR',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5);
                              return null; // Use the component's default.
                            },
                          )),
                          child: Text(
                            'REFRESH',
                            style: TextStyle(color: Colors.amber, fontSize: 15),
                          ),
                          onPressed: () {
                            setState(() {
                              _series = 4;
                              _reps = 12;
                              _carga = 25;
                            });
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ), // ignore: deprecated_member_use
                        TextButton(
                          child: Text(
                            'CRIAR',
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          onPressed: () {
                            setState(() {
                              _addExercicio(
                                  muscleId: doc.docs[index]["muscleId"],
                                  title: doc.docs[index]["title"],
                                  description: doc.docs[index]["description"],
                                  planilhaId: treinoId,
                                  userId: model.firebaseUser.uid,
                                  series: _series.toString(),
                                  reps: _reps.toString(),
                                  carga: _carga,
                                  pos: doc.docs.length);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Future<Null> _addExercicio(
      {@required String muscleId,
      @required String title,
      @required String description,
      @required String planilhaId,
      @required userId,
      String reps,
      String series,
      int carga,
      int pos}) {
    print("$pos posição");
    if (pos == null) pos = 1;
    setState(() {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("planilha")
          .doc(planilhaId)
          .collection("exercícios")
          .add({
        "muscleId": muscleId,
        "title": title,
        "description": description,
        "series": series,
        "reps": reps,
        "peso": carga,
        "pos": pos + 1
      }).then((_) {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Exercício adicionado com sucesso!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ));
        Future.delayed(Duration(seconds: 10));
        print("Exercicio criada com sucesso");
      }).catchError((_) {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content:
              Text("Exercício não adicionado, tentar novamente mais tarde!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
        Future.delayed(Duration(seconds: 10));
        print("Ocorreu um erro");
      });
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              "${title.toUpperCase()}",
              style: TextStyle(fontSize: 30, fontFamily: "GothamBold"),
            ),
            centerTitle: true,
          ),
          backgroundColor: Color(0xff313131),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("musculos")
                  .doc(title.toLowerCase())
                  .collection("exercícios")
                  .snapshots(),
              builder: (context, snapshot) {
                var doc = snapshot.data;
                if (doc == null)
                  return Center(child: CircularProgressIndicator());
                //print(title.toLowerCase());
                //print(doc.docs.length);
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(7),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onDoubleTap: addMode
                              ? () {
                                  _displayModalBottom(
                                      context, doc, model, index);

                                  print(
                                      "${doc.docs[index]["title"]} :  ${model.firebaseUser.uid}");
                                }
                              : () {
                                  print("AINDA NOPE");
                                },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      2, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(accentColor: Colors.grey[700]),
                              child: ExpansionTile(
                                  title: Text(
                                    doc.docs[index]["title"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "GothamBold",
                                    ),
                                  ),
                                  children: [
                                    Text(
                                      doc.docs[index]["description"],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "GothamBook",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ]),
                            ),
                          ),
                        );
                      });
              }),
        ),
      );
    });
  }
}
