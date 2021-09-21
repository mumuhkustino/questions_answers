import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:questions_answers/quiz_response.dart';
import 'package:http/http.dart' as http;
import 'package:questions_answers/quiz_result_page.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Uri apiURL = Uri.parse(
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple");
  QuizResponse? quizResponse;

  int currentQuestion = 0;

  int totalSeconds = 30;
  int elapsedSeconds = 0;

  Timer? timer;

  int score = 0;

  @override
  void initState() {
    fetchAllQuiz();
    super.initState();
  }

  initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == totalSeconds) {
        print("Time completed");
        timer.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedSeconds = timer.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  fetchAllQuiz() async {
    var response = await http.get(apiURL);
    var body = response.body;

    var json = jsonDecode(body);

    print(body);

    setState(() {
      quizResponse = QuizResponse.fromJson(json);
      quizResponse!.results![currentQuestion].incorrectAnswers!
          .add(quizResponse!.results![currentQuestion].correctAnswer!);

      quizResponse!.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    });
  }

  checkAnswer(answer) {
    final String correctAnswer =
        quizResponse!.results![currentQuestion].correctAnswer!;
    if (correctAnswer == answer) {
      print("Correct");
      score += 1;
    } else {
      print("Wrong");
    }
    changeQuestion();
  }

  changeQuestion() {
    timer?.cancel();

    if (currentQuestion == quizResponse!.results!.length - 1) {
      print("Quiz Completed");
      print("Score: $score");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizResult(score: score,)));
    } else {
      setState(() {
        currentQuestion += 1;
      });

      quizResponse!.results![currentQuestion].incorrectAnswers!
          .add(quizResponse!.results![currentQuestion].correctAnswer!);

      quizResponse!.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizResponse != null) {
      return Scaffold(
        backgroundColor: Color(0XFF587291),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage("assets/logo_circle.png"),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        "$elapsedSeconds seconds",
                        style:
                            TextStyle(color: Color(0XFF0CF574), fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Q. ${quizResponse!.results![currentQuestion].question}",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: Column(
                      children: quizResponse!
                          .results![currentQuestion].incorrectAnswers!
                          .map((option) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: RaisedButton(
                              onPressed: () {
                                checkAnswer(option);
                              },
                              color: Color(0XFF2F97C1),
                              // colorBrightness: Brightness.dark,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                option,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ));
                      }).toList(),
                    )),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0XFF587291),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
