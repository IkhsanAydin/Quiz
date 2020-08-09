import 'pertanyaan.dart';

class QuizLogic {
  List<Question> _questionList = [
    Question('Benarkah Corona Sangat Berbahaya??.', true),
    Question('Apakah Corona Berasal dari Cina??', true),
    Question('Apakah Corona Hanya Ada Di Cina??.', false),
    Question('Apakah Kita Harus Waspada Terhadap Corona??', true),
    Question('Apakah Kita Harus Tetap Dirumah??', true),
    Question(
        'Kalau Kita Ingin Keluar Apakah Kita Harus Menggunakan Masker??', true),
    Question('Apakah Kita Boleh Panik Ketika Ada Corona??', false),
    Question('Apakah Indonesia Banyak Yang Terkena Corona??', true),
    Question('Apakah Indonesia Aman Dari Corona??', false),
    Question(
        'Apakah Kita Harus Berdoa, Dan Bersabar Ketika Terkena Corona??', true),
  ];

  int _questionIndex = 0;

  String getQuestion() {
    return _questionList[_questionIndex].question;
  }

  int getTotalQuestion() => _questionList.length;

  int getNumberOfQuestion() => _questionIndex + 1;

  bool getAnswer() => _questionList[_questionIndex].answer;

  void nextQuestion() {
    if (_questionIndex < getTotalQuestion()) {
      _questionIndex++;
      print('index soal ke $_questionIndex');
      print(('sekarang soal ke $getNumberOfQuestion()()'));
    }
  }

  bool isFinnish() {
    if (_questionIndex >= getTotalQuestion() - 1) {
      return true;
    } else {
      return false;
    }
  }

  void resetQuestion() => _questionIndex = 0;
}
