// ignore_for_file: unnecessary_import, prefer_const_constructors, deprecated_member_use, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/main_menu.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart';
import 'package:flutter_quiz_app/ui/shared/color.dart';

class ResultScreen extends StatefulWidget {
  int score;
  ResultScreen(this.score, {Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pripmaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Tebrikler",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Text(
            "Puanın",
            style: TextStyle(color: Colors.white, fontSize: 34.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "${widget.score}",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 85.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizzScreen(),
                  ));
            },
            shape: StadiumBorder(),
            color: AppColor.secondaryColor,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Tekrar Çöz",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainMenu(),
                  ));
            },
            shape: StadiumBorder(),
            color: AppColor.secondaryColor,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Ana Menüye Dön",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}