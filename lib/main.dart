import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'logic.dart';

QuizLogic questionLogic = QuizLogic();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizApps',
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Color(0xFF00838F),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'QUIZ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'app',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreResult = [];

  void checkAnswer(bool answer) {
    //variable untuk menyimpan kunci jawaban soal sekarang
    bool correctAnswer = questionLogic.getAnswer();

    //cek apakah quiz sudah selesai atau belum
    //mengubah kondisi tampilan
    setState(() {
      //jika selesai maka
      if (questionLogic.isFinnish()) {
        //tampilkan dialog
        Alert(
            context: context,
            type: AlertType.success,
            title: 'Quiz Selesai',
            buttons: [
              DialogButton(
                child: Text(
                  'finish',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ]).show();

        questionLogic.resetQuestion();
        scoreResult.clear();
      } else {
        //jika quiz belum selesai
        //kita tampilkan/tambahkan hasilnya
        //cek apakah jawaban user sama dengan kunci jawabannya
        if (answer == correctAnswer) {
          scoreResult.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreResult.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        //lanjut ke soal berikutnya
        questionLogic.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: scoreResult,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey,
              ),
              child: Text(
                questionLogic.getNumberOfQuestion().toString() +
                    '/' +
                    questionLogic.getTotalQuestion().toString(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              questionLogic.getQuestion(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: () {
                  checkAnswer(false);
                },
                child: Text('SALAH'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.red),
                ),
                color: Colors.red,
              ),
            ),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  checkAnswer(true);
                },
                child: Text('BENAR'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.green)),
                color: Colors.green,
              ),
            )
          ],
        )
      ],
    );
  }
}
