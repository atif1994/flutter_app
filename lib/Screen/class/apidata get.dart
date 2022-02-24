import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screen/Models.dart';
import 'package:flutter_app/Screen/class/Services.dart';
import '../Models.dart';

import 'Services.dart';
import 'color.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key key}) : super(key: key);

  @override
  QuizState createState() => QuizState();
}

List<getData> myList = [];

class QuizState extends State<Quiz> {
  int timer = 10;
  String showtimer;
  bool canceltimer = false;
  dynamic i;

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    if (timer == 0) {
      f = f + 1;
    }
    if (timer == 0 && f < 4) {
      color = Colors.teal;
      color1 = Colors.teal;
      color2 = Colors.teal;
      color3 = Colors.teal;
      timer = timer + 10;
    }
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Result"),
    content: Text("youe marks is :${rightAnsScore}"),
    actions: [],
  );
  Color color = Colors.teal;
  Color color1 = Colors.teal;
  Color color2 = Colors.teal;
  Color color3 = Colors.teal;

  @override
  void initState() {
    super.initState();
    starttimer();
    Services.getApiData().then((getData) {
      setState(() {
        myList = getData;
      });
    });
  }

  int f = 0;
  int rightAnsScore = 0;
  int _totalQue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          Container(
            width: 35,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.white)),
            child: const Text('16'),
          )
        ],
      ),
      body: Container(
          color: Colors.white,
          child: PageView.builder(
              itemCount: null == myList ? 0 : myList.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // CLIPPATH POLYGON
                          ClipPath(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              color: Colors.deepPurpleAccent.shade200,
                            ),
                            clipper: CustomClipPath(),
                          ),
                          // QUESTION AND ANSWER
                          Positioned(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 90,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent[100],
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
                                ),
                                child: Text('${f}/4'),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [],
                                  )),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [],
                                  ))
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text('${myList[f].question}'),
                                    //const Text('First Human Transplant Operation Conducted by Dr.Christiaan Barnard on Louis Washkansky was conducted in',style: TextStyle(color: Colors.white,wordSpacing: 10),),
                                  ],
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.teal),
                                  child: Text(
                                    "${showtimer}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.deepOrange[400]),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (f < 4) {
                                            f++;
                                            showtimer;
                                          }
                                        });
                                        if (f == 4) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        }

                                      },
                                      icon: const Icon(
                                        Icons.skip_next_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red[400]),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          f = 0;
                                          if (f < 5) {
                                            f = 0;
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // MULTIPLE CHOICE
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              buttonA();
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              padding: const EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: Text("A"),
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                        flex: 9,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${myList[f].correctAnswers.answerACorrect}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              buttonB();
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              decoration: BoxDecoration(
                                color: color1,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'B',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          )
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                      flex: 9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${myList[f].answers.answerB}',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              buttonc();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                // color: Colors.teal,
                                decoration: BoxDecoration(
                                  color: color2,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              padding: const EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'C',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                        flex: 9,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ' ${myList[f].answers.answerC}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              buttond();
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              decoration: BoxDecoration(
                                color: color3,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'D',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          )
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                      flex: 9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ' ${myList[f].answers.answerD} ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }

  void backgroundColor(MaterialColor amber) {}

  buttonA() {
    setState(() {
      if (myList[f].correctAnswers.answerACorrect == "true") {
        color = Colors.green;
        rightAnsScore++;
      }
      if (myList[f].correctAnswers.answerACorrect == "false") {
        color = Colors.red;
      }
    });

  }

  buttonB() {
    setState(() {
      if (myList[f].correctAnswers.answerBCorrect == "true") {
        color1 = Colors.green;
        rightAnsScore++;
      }
      if (myList[f].correctAnswers.answerBCorrect == "false") {
        color1 = Colors.red;
      }
    });

      rightAnsScore++;

  }

  buttonc() {
    setState(() {
      if (myList[f].correctAnswers.answerCCorrect == "true") {
        color2 = Colors.green;
        rightAnsScore++;
      }
      if (myList[f].correctAnswers.answerCCorrect == "false") {
        color2 = Colors.red;
      }
    });



  }

  buttond() {
    setState(() {
      if (myList[f].correctAnswers.answerDCorrect == "true") {
        color3 = Colors.green;
        rightAnsScore++;
      }
      if (myList[f].correctAnswers.answerDCorrect == "false") {
        color3 = Colors.red;
      }
    });

  }
}

//CLIPPATH POLYGON
class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 30;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height ? size.height - 20 : size.height;
      path.lineTo(curXPos, curYPos);
    }
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
