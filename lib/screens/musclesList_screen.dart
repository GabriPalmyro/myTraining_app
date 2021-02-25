import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:tabela_treino/ads/ads_model.dart';
import 'muscle_screen.dart';

class MuscleListScreen extends StatefulWidget {
  final String treinoId;
  final bool addMode;
  MuscleListScreen(this.addMode, this.treinoId);
  @override
  _MuscleListScreenState createState() =>
      _MuscleListScreenState(addMode, treinoId);
}

class _MuscleListScreenState extends State<MuscleListScreen> {
  //CREATE INTERSTITIAL
  InterstitialAd interstitialAdMuscle;
  int adClick = 0;

  InterstitialAd buildInterstitial(String title) {
    return InterstitialAd(
        adUnitId: intertstitialAdIdAndroid,
        targetingInfo: MobileAdTargetingInfo(testDevices: <String>[]),
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myInterstitial?.show();
          }
          if (event == MobileAdEvent.clicked || event == MobileAdEvent.closed) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MuscleScreen(title, addMode, treinoId)));
            adClick = 0;
            myInterstitial.dispose();
          }
          if (event == MobileAdEvent.failedToLoad) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MuscleScreen(title, addMode, treinoId)));
            adClick = 0;
          }
        });
  }

  final bool addMode;
  final String treinoId;
  _MuscleListScreenState(this.addMode, this.treinoId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Músculos",
            style: TextStyle(fontSize: 30, fontFamily: "GothamBold"),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xff313131),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("musculos")
              .orderBy("title")
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 28,
                      crossAxisSpacing: 25,
                      childAspectRatio: 0.65),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final String title = snapshot.data.docs[index]["title"];
                    return GestureDetector(
                      onTap: () {
                        print(adClick);
                        if (addMode == true) {
                          if (adClick < 1) {
                            adClick++;
                            interstitialAdMuscle = buildInterstitial(title)
                              ..load()
                              ..show();
                          }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MuscleScreen(title, addMode, treinoId)));
                        }
                      },
                      child: Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 0.85,
                              child: Image.network(
                                snapshot.data.docs[index]["icon"],
                                scale: 0.3,
                              ),
                            ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(7),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data.docs[index]["title"],
                                    style: TextStyle(
                                        fontFamily: "GothamBold", fontSize: 20),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
