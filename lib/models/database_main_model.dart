class QuizMainModel {
  QuizMainModel({
    required this.origin,
    required this.defination,
    required this.word,
    required this.pronunciation,
    required this.part_of_speech,
    required this.sentence,
    required this.multiplechoices,
    required this.Matchword,
    required this.SpellingMc,
  });

  String word, origin, part_of_speech, defination, sentence, pronunciation;
  MCQS multiplechoices;
  MC SpellingMc;
  MW Matchword;

  factory QuizMainModel.fromMap(element) {
    return QuizMainModel(
        word: element['word'],
        origin: element['origin'],
        defination: element['defination'],
        pronunciation: element['pronunciation'],
        part_of_speech: element['part_of_speech'],
        sentence: element['sentence'],
        multiplechoices: MCQS(
            Mcq_Question: element['Mcq Question'],
            Mcq_Option_A: element['Mcq Option_A'],
            Mcq_Option_B: element['Mcq Option_B'],
            Mcq_Option_C: element['Mcq Option_C'],
            Mcq_Option_D: element['Mcq Option_D'],
            Mcq_CorrectAnswer: element['Mcq CorrectAnswer']),
        Matchword: MW(
            Mw_Option_A: element['Mw Option A'],
            Mw_Option_B: element['Mw Option B'],
            Mw_Option_C: element['Mw Option C'],
            Mw_Option_D: element['Mw Option D'],
            Mw_CorrectAnswer: '${element['Mw CorrectAnswer']}'),
        SpellingMc: MC(
            Mc_Option_A: element['Mc Option A'],
            Mc_Option_B: element['Mc Option B'],
            Mc_Option_C: element['Mc Option C'],
            Mc_Option_D: element['Mc Option D'],
            Mc_CorrectAnswer: '${element['Mc CorrectAnswer']}'));
  }
}

class MCQS {
  MCQS({
    required this.Mcq_Question,
    required this.Mcq_Option_A,
    required this.Mcq_Option_B,
    required this.Mcq_Option_C,
    required this.Mcq_Option_D,
    required this.Mcq_CorrectAnswer,
  });
  String Mcq_Question,
      Mcq_Option_A,
      Mcq_Option_B,
      Mcq_Option_C,
      Mcq_Option_D,
      Mcq_CorrectAnswer;
}

class MW {
  MW({
    required this.Mw_Option_A,
    required this.Mw_Option_B,
    required this.Mw_Option_C,
    required this.Mw_Option_D,
    required this.Mw_CorrectAnswer,
  });
  String Mw_Option_A, Mw_Option_B, Mw_Option_C, Mw_Option_D, Mw_CorrectAnswer;
}

class MC {
  MC({
    required this.Mc_Option_A,
    required this.Mc_Option_B,
    required this.Mc_Option_C,
    required this.Mc_Option_D,
    required this.Mc_CorrectAnswer,
  });
  String Mc_Option_A, Mc_Option_B, Mc_Option_C, Mc_Option_D, Mc_CorrectAnswer;
}
