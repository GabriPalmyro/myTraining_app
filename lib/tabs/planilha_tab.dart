import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tabela_treino/ads/ads_model.dart';
import 'package:tabela_treino/screens/meuTreino_screen.dart';
import 'package:tabela_treino/models/user_model.dart';
import 'package:tabela_treino/widgets/custom_drawer.dart';

class PlanilhaScreen extends StatefulWidget {
  @override
  _PlanilhaScreenState createState() => _PlanilhaScreenState();
}

class _PlanilhaScreenState extends State<PlanilhaScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _titleController = TextEditingController();
  final _descriController = TextEditingController();

  Future<void> _displayModalBottom(BuildContext context) async {
    return showModalBottomSheet(
        backgroundColor: Colors.grey[850],
        context: context,
        builder: (context) {
          return Column(
            children: [
              Container(
                color: Colors.grey[850],
                height: MediaQuery.of(context).size.height * 0.4,
                margin: EdgeInsets.all(20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      "Criar novo treino: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gotham",
                          fontSize: 25),
                      textAlign: TextAlign.start,
                    ),
                    Divider(
                      color: Colors.white,
                    ),
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
                    // ignore: deprecated_member_use
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.red.withOpacity(0.5);
                              return null; // Use the component's default.
                            },
                          )),
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
                        TextButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green.withOpacity(0.5);
                              return null; // Use the component's default.
                            },
                          )),
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
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  // ignore: missing_return
  Future<Null> _createNew(
      {@required String title, @required String description}) {
    setState(() {
      FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .collection("planilha")
          .add({"title": title, "description": description}).then((_) {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Treino adicionado com sucesso!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ));
        print("Treino criada com sucesso");
      }).catchError((_) {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Ocorreu um erro!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
        print("Ocorreu um erro");
      });
    });
  }

  String title;
  String description;
  bool payApp = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        payApp = value.data()["payApp"];
      });
      print(bottomPadding);
      return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          toolbarHeight: 70,
          shadowColor: Colors.grey[850],
          elevation: 25,
          centerTitle: true,
          title: Text(
            "Planilhas",
            style: TextStyle(
                color: Colors.grey[850],
                fontFamily: "GothamBold",
                fontSize: 30),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        key: _scaffoldKey,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Container(
            height: 60.0,
            width: 55.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _displayModalBottom(context);
                  });
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.grey[700],
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
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
                    shrinkWrap: true,
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
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(30.0)),
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
                                          fontSize: 25,
                                          fontFamily: "GothamBold"),
                                      textAlign: TextAlign.center,
                                    ),
                                    Divider(),
                                    Text(
                                      snapshot.data.docs[index]["description"],
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: "GothamBook"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
