import '../models/database_main_model.dart';

final List<QuizMainModel> BeginersA = [
  QuizMainModel(
    word: 'Share',
    pronunciation: '/sher/',
    origin: 'This word is originally english',
    part_of_speech: 'verb',
    defination: 'to use, experience or enjoy with others',
    sentence: 'i shared my lunch with my friends today.',
    multiplechoices: MultipleChoices(
        Question: 'What we cant share ?',
        Option_A: 'Books',
        Option_B: 'Hand',
        Option_C: 'Eyes',
        Option_D: 'Hsumans',
        CorrectAnswer: '1'),
  ),
  QuizMainModel(
    word: 'Send',
    pronunciation: '/send/',
    origin: 'This word is originally english',
    part_of_speech: 'verb',
    defination:
        'to cause something to go from one place to another, especially by post or email:',
    sentence: '''Maggie sends her love and hopes you'll feel better soon.''',
    multiplechoices: MultipleChoices(
        Question: 'how to spell send?',
        Option_A: 'send',
        Option_B: 'sand',
        Option_C: 'snd',
        Option_D: 'sen',
        CorrectAnswer: '1'),
  ),
  QuizMainModel(
    word: 'beautiful',
    pronunciation: '/beau·​ti·​ful/',
    origin: 'This word is originally english',
    part_of_speech: 'adjective',
    defination: 'having qualities of beauty : exciting aesthetic pleasure',
    sentence: 'beautiful mountain scenery.',
    multiplechoices: MultipleChoices(
        Question: 'beautiful can be used for?',
        Option_A: 'Women',
        Option_B: 'Man',
        Option_C: 'Asim',
        Option_D: 'Waseem',
        CorrectAnswer: '1'),
  ),
];
