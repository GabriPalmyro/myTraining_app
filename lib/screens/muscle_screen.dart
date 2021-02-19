import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:numberpicker/numberpicker.dart';

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
  final String treinoId;

  final String title;
  final bool addMode;
  _MuscleScreenState(this.title, this.addMode, this.treinoId);

  final _seriesController = TextEditingController();
  final _repsController = TextEditingController();
  int _cargaController = 25;

  void _displayTextInputDialog(BuildContext context, QuerySnapshot doc,
      UserModel model, int index) async {
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
              'Detalhe seu exercício',
              style: TextStyle(color: Colors.white, fontFamily: "GothamBold"),
            ),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        labelText: "Séries",
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
                        hintText: "Quantidade de séries",
                        hintStyle: TextStyle(
                            color: Colors.grey[300].withOpacity(0.3))),
                    controller: _seriesController,
                  ),
                  TextField(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        labelText: "Quantidade de repetições",
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
                        hintText: "Quantidade de repetições",
                        hintStyle: TextStyle(
                            color: Colors.grey[300].withOpacity(0.3))),
                    controller: _repsController,
                  ),
                  Container(
                    height: 50,
                    child: NumberPicker.integer(
                      initialValue: _cargaController,
                      minValue: 0,
                      maxValue: 200,
                      onChanged: (value) {
                        setState(() {
                          _cargaController = value;
                        });
                      },
                    ),
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
                    _addExercicio(
                        muscleId: doc.docs[index]["muscleId"],
                        title: doc.docs[index]["title"],
                        description: doc.docs[index]["description"],
                        planilhaId: treinoId,
                        userId: model.firebaseUser.uid,
                        series: _seriesController.text,
                        reps: _repsController.text,
                        carga: _cargaController,
                        pos: doc.docs.length + 1);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
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
      int pos}) async {
    if (pos == null) pos = 1;
    setState(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("planilha")
          .doc(treinoId)
          .collection("exercícios")
          .add({
        "muscleId": muscleId,
        "title": title,
        "description": description,
        "series": series,
        "reps": reps,
        "peso": carga,
        "pos": pos
      }).then((_) {
        print("Treino criada com sucesso");
      }).catchError((_) {
        print("Ocorreu um erro");
      });
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
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
                            ? () async {
                                _displayTextInputDialog(
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
                                offset:
                                    Offset(2, 5), // changes position of shadow
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
      );
    });
  }
}
