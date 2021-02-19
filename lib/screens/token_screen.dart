import 'dart:math';
import 'package:flutter/material.dart';

class TokenScreen extends StatefulWidget {
  @override
  _TokenScreenState createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Token"),
        ),
        backgroundColor: Color(0xff313131),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    int min = 100000;
                    int max = 999999;
                    var randomizer = new Random();
                    token = (min + randomizer.nextInt(max - min)).toString();
                  });

                  print(token);
                  //min and max values act as your 6 digit range
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
