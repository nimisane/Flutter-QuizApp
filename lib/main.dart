import 'package:flutter/material.dart';
import 'package:quiz_app/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionsBank questionBank = QuestionsBank();

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: QuizPage(),
      ),
      backgroundColor: Colors.grey.shade900,
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreIcons = [];

  int questionNumber = 0;

  void checkAnswer(bool userAnswers) {
    if (questionBank.isFinished() == true) {
      //TODO Step 4 Part A - show an alert using rFlutter_alert,

      //This is the code for the basic alert from the docs for rFlutter Alert:
      //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

      Alert(
        context: context,
        title: 'Finished!',
        desc: 'You\'ve reached the end of the quiz.',
      ).show();

      //TODO Step 4 Part C - reset the questionNumber,
      questionBank.reset();

      //TODO Step 4 Part D - empty out the scoreKeeper.
      scoreIcons.clear();
    } else {
      if (questionBank.getAnswers() == userAnswers) {
        scoreIcons.add(Icon(Icons.check, color: Colors.green));
      } else {
        scoreIcons.add(Icon(Icons.close, color: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  questionBank.getQuestions(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: () {
                setState(() {
                  checkAnswer(true);

                  questionBank.nextQuestion();
                 
                });
              },
              child: Text('True',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              //color: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  checkAnswer(false);

                  questionBank.nextQuestion();
                 
                });
              },
              color: Colors.red,
              child: Text(
                'False',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),
        Row(children: scoreIcons)
      ],
    );
  }
}
