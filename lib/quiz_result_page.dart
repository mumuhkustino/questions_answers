import 'package:flutter/material.dart';
import 'package:questions_answers/quiz_page.dart';

class QuizResult extends StatelessWidget {
  final int score;
  
  const QuizResult({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF587291),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Image(
                  image: AssetImage("assets/logo_circle.png"),
                  width: 300,
                  height: 300,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Result",
                style: TextStyle(color: Color(0XFF15E6CD), fontSize: 30),
              ),
              Text(
                "$score / 10",
                style: TextStyle(color: Color(0XFF15E6CD), fontSize: 30),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "RESTART",
                      style: TextStyle(fontSize: 32),
                    ),
                    color: Color(0XFF15E6CD),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(),
                          ));
                    }),
              ),
                            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 30
                ),
                child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "MAIN MENU",
                      style: TextStyle(fontSize: 32),
                    ),
                    color: Color(0XFF15E6CD),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
