// ignore_for_file: unused_import, non_constant_identifier_names, prefer_const_constructors, unnecessary_new, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/data/questions_example.dart';
import 'package:flutter_quiz_app/screens/result_screen.dart';
import 'package:flutter_quiz_app/ui/shared/color.dart';
import 'package:flutter_quiz_app/widgets/quiz_widget.dart';
import 'package:flutter_quiz_app/model/questions_model.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;
  int score = 0;
  int counter = 0;
  int time_counter = 15;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Sonraki Soru";
  late Timer _timer;
  bool answered = false;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    startCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pripmaryColor,
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == questions.length - 1) {
                setState(() {
                  btnText = "Sonucu Gör";
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Soru ${index + 1}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                      Container(
                        width: 143,
                      ),
                      Text(
                        "Kalan Hak : ${3 - counter}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),

                  /*
                  SizedBox(
                    //width: double.infinity,
                    child: Text(
                      "Soru ${index + 1}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "Kalan Hak : ${3 - counter}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  */
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: Text(
                      "${questions[index].question}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: btnPressed
                            ? questions[index].answers!.values.toList()[i]
                                ? Colors.green
                                : Colors.red
                            : AppColor.secondaryColor,
                        onPressed: !answered
                            ? () {
                                setState(() {
                                  _timer.cancel();
                                });

                                if (questions[index]
                                    .answers!
                                    .values
                                    .toList()[i]) {
                                  score++;
                                  print("yes");
                                } else {
                                  counter++;
                                  if (counter == 3) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResultScreen(score)));
                                  }
                                  print("no");
                                }
                                setState(() {
                                  btnPressed = true;
                                  answered = true;
                                });
                              }
                            : null,
                        child: Text(questions[index].answers!.keys.toList()[i],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            )),
                      ),
                    ),
                  SizedBox(
                    child: Text(
                      '$time_counter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      _timer.cancel();
                      if (_controller!.page?.toInt() == questions.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(score)));
                      } else {
                        startCounter();
                        _controller!.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInExpo);
                        setState(() {
                          btnPressed = false;
                        });
                      }
                    },
                    shape: StadiumBorder(),
                    fillColor: Colors.blue,
                    padding: EdgeInsets.all(18.0),
                    elevation: 0.0,
                    child: Text(
                      btnText,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            },
            itemCount: questions.length,
          )),
    );
  }

  void startCounter() {
    time_counter = 15;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time_counter > 0) {
          time_counter--;
        } else {
          _timer.cancel();
          _controller!.nextPage(
              duration: Duration(milliseconds: 250), curve: Curves.easeInExpo);
          startCounter();
        }
      });
    });
  }
}
