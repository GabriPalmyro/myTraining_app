import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tabela_treino/screens/home_screen.dart';
import 'package:tabela_treino/screens/intro_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'My Training',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xffffd200),
        ),
        debugShowCheckedModeBanner: false,
        home: _auth.currentUser == null ? IntroScreen() : HomeScreen(),
      ),
    );
  }
}
