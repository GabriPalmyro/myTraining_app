import 'dart:math';
import 'package:flutter/material.dart';

class TokenScreen extends StatefulWidget {
  @override
  _TokenScreenState createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  void _creatToken() {
    setState(() {
      int min = 100000;
      int max = 999999;
      //var atualTime = DateTime.now();
      //var finalTime = atualTime.add(Duration(seconds: 30));
      var randomizer = new Random();
      token = (min + randomizer.nextInt(max - min)).toString();
      // while (atualTime != finalTime) {}
      token = "Token expirado";
    });
    print(token);
    //min and max values act as your 6 digit range
  }

  String token = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Token"),
          centerTitle: true,
        ),
        backgroundColor: Color(0xff313131),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  _creatToken();
                },
                child: Icon(Icons.create),
              ),
              Text(
                "$token",
                style: TextStyle(fontSize: 50, color: Colors.white),
              )
            ],
          ),
        ));
  }
}
