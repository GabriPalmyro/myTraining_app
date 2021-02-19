import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MuscleScreen extends StatefulWidget {
  final String title;
  MuscleScreen(this.title);

  @override
  _MuscleScreenState createState() => _MuscleScreenState(title);
}

class _MuscleScreenState extends State<MuscleScreen> {
  final String title;
  _MuscleScreenState(this.title);

  @override
  Widget build(BuildContext context) {
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
            if (doc == null) return Center(child: CircularProgressIndicator());
            print(title.toLowerCase());
            print(doc.docs.length);
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
                    return InkWell(
                      onTap: () {},
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
  }
}
