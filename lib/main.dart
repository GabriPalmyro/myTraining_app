import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:tabela_treino/screens/login_screen.dart';
import 'package:tabela_treino/screens/home_screen.dart';

import 'ads/ads_model.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  //SystemChrome.setEnabledSystemUIOverlays([]);
  FirebaseAdMob.instance
      .initialize(appId: "ca-app-pub-7831186229252322~9095625736");

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
bool payApp = false;

class _MyAppState extends State<MyApp> {
  void displayBanner() {
    myBanner
      ..load()
      ..show(
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      ).then((value) {
        print("anuncio mostrado");
      }).catchError((_) {
        print("ERRO $_");
      });
  }

  @override
  void dispose() {
    myBanner?.dispose();
    myInterstitial?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-7831186229252322~9095625736");

    //Map<String, dynamic> doc;

    /*if (_auth.currentUser != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        payApp = value.data()["payApp"];
        print(payApp);
        if (payApp != true) {
          startBanner();
          displayBanner();
        }
      });
    } else {*/
    startBanner();
    displayBanner();
    //}
  }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        payApp = value.data()["payApp"];
      });
    }
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          title: 'My Training',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xffffd200),
          ),
          debugShowCheckedModeBanner: false,
          home: _auth.currentUser == null ? LoginScreen() : HomeScreen(),
        ));
  }
}
