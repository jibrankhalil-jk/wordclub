class QuizMainModel {


  QuizMainModel({
    required this.origin,
    required this.defination,
    required this.word,
    required this.pronunciation,
    required this.part_of_speech,
    required this.sentence,
    required this.multiplechoices,
  });

  String word, origin, part_of_speech, defination, sentence, pronunciation;
  MultipleChoices multiplechoices;
  
  factory QuizMainModel.fromMap(element) {
    return QuizMainModel(
        word: element['word'],
        origin: element['origin'],
        defination: element['defination'],
        pronunciation: element['pronunciation'],
        part_of_speech: element['part_of_speech'],
        sentence: element['sentence'],
        multiplechoices: MultipleChoices(
            Question: element['Question'],
            Option_A: element['Option_A'],
            Option_B: element['Option_B'],
            Option_C: element['Option_C'],
            Option_D: element['Option_D'],
            CorrectAnswer: '${element['CorrectAnswer']}'));
  }
}

class MultipleChoices {
  MultipleChoices({
    required this.Question,
    required this.Option_A,
    required this.Option_B,
    required this.Option_C,
    required this.Option_D,
    required this.CorrectAnswer,
  });
  String Question, Option_A, Option_B, Option_C, Option_D, CorrectAnswer;
}
