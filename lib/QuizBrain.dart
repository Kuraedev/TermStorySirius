import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _score = 0;

  final List<Question> _questionBank = [
    Question(
      questionText:
          'Shorekeeper is the first instance, the first resonator',
      questionAnswer: false,
    ),
    Question(
      questionText: 'The main protagonist of Armored Core 6 is Augmented Human C4-621',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'Orphan of Kos is the first boss in Bloodborne\'s DLC, The Old Hunters.',
      questionAnswer: false,
    ),
    Question(
      questionText:
          'Podophilia is the attraction to feet.',
      questionAnswer: true,
    ),
    Question(
      questionText: 'In the 86 Anime, the song title LilaS by Hiroyuki Sawano is a nudge to their first meeting. "Lena is looking at Shin"',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'Violet Evergarden is not a Auto Memory Doll. ',
      questionAnswer: false,
    ),
    Question(
      questionText: 'The JGSDF Type-10 Main Battle Tank is the lightest amongst western designs at 44 tons and is effectively considered the least armored MBT in service. While in contrast the Merkava Mk.4 "Windbreaker"(80+ Tons) is the heaviest but is surprisingly maneuverable even said to be a "Fat man that can run"',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'The KMS Bismarck was launched on Valentine\'s Day',
      questionAnswer: true,
    ),

    Question(
      questionText:
          'Duchessa is the 20th member of the Parhelion organization within the Andromeda Corp. (Story lore drop, Parhelion contains the 20 best Operators of the the Andromeda Story.)',
      questionAnswer: false,
    ),

    Question(
      questionText:
          'In the Parhelion Organization "Stryker" is the codename of Carmine Sirius. (Last 2 questions are from a story/light novel draft by me that I cant seem to finish or get around completing the second volume so no one really knows about them.)',
      questionAnswer: true, 
    ),
  ];

  String getQuestionText() => _questionBank[_questionNumber].questionText;

  bool getQuestionAnswer() => _questionBank[_questionNumber].questionAnswer;

  int getQuestionNumber() => _questionNumber;

  int getTotalQuestions() => _questionBank.length;

  int getScore() => _score;

  bool isLastQuestion() => _questionNumber >= _questionBank.length - 1;

  bool checkAndAdvance(bool userAnswer) {
    bool correct = userAnswer == getQuestionAnswer();
    if (correct) _score++;
    if (!isLastQuestion()) _questionNumber++;
    return correct;
  }

  void reset() {
    _questionNumber = 0;
    _score = 0;
  }
}