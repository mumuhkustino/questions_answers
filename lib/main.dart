import 'package:flutter/material.dart';
import 'package:questions_answers/quiz_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Two Types Of App
    // Material
    // Cupertino - iOS Style

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "productSans"),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                "Quiz",
                style: TextStyle(color: Color(0XFF0CF574), fontSize: 30),
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
                      "PLAY",
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
            ],
          ),
        ),
      ),
    );
  }
}
