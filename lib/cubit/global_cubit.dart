import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:wordclub/data/beginers.dart';

import '../models/database_main_model.dart';
import '../models/wordpackmodel.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final GetStorage _getStorage = GetStorage();
  GlobalCubit() : super(GlobalInitial());
  TextToSpeech tts = TextToSpeech();

  Locale app_language =
      GetStorage().read('App_Language') == 'en' ? Locale('en') : Locale('ur');

  change_app_language_to_urdu() async {
    emit(GlobalDummystate());
    app_language = await Locale('ur');
    await _getStorage.write('App_Language', 'ur');
    emit(GlobalInitial());
  }

  change_app_language_to_english() async {
    emit(GlobalDummystate());
    app_language = await Locale('en');
    await _getStorage.write('App_Language', 'en');
    emit(GlobalInitial());
  }

  speak_with_tts(var text) async {
    await tts.speak(text);
  }

  inital_db_creating() async {
    var dbdir = await getApplicationDocumentsDirectory();
    ByteData dbfile = await rootBundle.load('assets/QuizDb.db');
    Uint8List dbbytes =
        dbfile.buffer.asUint8List(dbfile.offsetInBytes, dbfile.lengthInBytes);
    File decodedimgfile = await File("${dbdir.parent.path}/databases/QuizDb.db")
        .writeAsBytes(dbbytes);

    // Directory file = Directory('${dbdir.parent.path}/databases');
    // log('${file.listSync()}');
  }
//     List Tables = [
//       'Beginners Part A',
//       // 'Beginners Part B',
//       // 'Beginners Part C',
//       // 'Intermediate Part A',
//       // 'Intermediate Part B',
//       // 'Intermediate Part C',
//       // 'Advanced Part A',
//       // 'Advanced Part B',
//       // 'Advanced Part C',
//     ];
//     Database db = await openDatabase('QuizDb.db');
//     // await db.rawQuery('DROP TABLE "main"."Quizs";');
// // creating  Quiz table
//     await db.rawQuery('''CREATE TABLE "Quizs" (
//     	"id"	INTEGER,
//     	"Name"	TEXT,
//     	"Level"	INTEGER,
//     	"UrduName" TEXT,
//     	PRIMARY KEY("id" AUTOINCREMENT)
//     )''');
// // creating tables
//     for (var element in Tables) {
//       await db.rawQuery('''CREATE TABLE "$element" (
// 	            "id"	INTEGER,
//               "word" TEXT,
//               "origin" TEXT,
//               "part_of_speech"  TEXT,
//               "defination"  TEXT,
//               "sentence" TEXT,
//               "pronunciation" TEXT,
//               "Question" Text,
//               "Option_A" Text,
//               "Option_B" Text,
//               "Option_C" Text,
//               "Option_D" Text,
//               "CorrectAnswer" INTEHER,
// 	            PRIMARY KEY("id" AUTOINCREMENT)
//         )''');
//     }
// // adding data to tables
//     Adding_Data_to_tables(db, BeginersA, Tables[0], 1, '');

//     db.close();
//   }

  // Adding_Data_to_tables(
  //   Database db,
  //   List<QuizMainModel> data,
  //   tablename,
  // ) async {
  //   // for (var index = 0; index <= data.length; index++) {
  //   data.forEach((element) async {
  //     // await db.insert(
  //     //    '\'$tablename\'',
  //     //     {
  //     //       "word": element.word,
  //     //       "origin": element.origin,
  //     //       "part_of_speech": element.part_of_speech,
  //     //       "defination": element.defination,
  //     //       "sentence": element.sentence,
  //     //       "pronunciation": element.pronunciation,
  //     //       "Question": element.multiplechoices.Question,
  //     //       "Option_A": element.multiplechoices.Option_A,
  //     //       "Option_B": element.multiplechoices.Option_B,
  //     //       "Option_C": element.multiplechoices.Option_C,
  //     //       "Option_D": element.multiplechoices.Option_D,
  //     //       "CorrectAnswer": element.multiplechoices.CorrectAnswer
  //     //     },
  //     //     conflictAlgorithm: ConflictAlgorithm.replace);

  //     await db.rawQuery(
  //         'INSERT INTO \"main\".\"$tablename\"(\"id\",\"word\",\"origin\",\"part_of_speech\",\"defination\",\"sentence\",\"pronunciation\",\"Question\",\"Option_A\",\"Option_B\",\"Option_C\",\"Option_D\",\"CorrectAnswer\") VALUES (NULL,\"${element.word}\",\"${element.origin}\",\"${element.part_of_speech}\",\"${element.defination}\",\"${element.sentence}\",\"${element.pronunciation}\",\"${element.multiplechoices.Question}\",\"${element.multiplechoices.Option_A}\",\"${element.multiplechoices.Option_B}\",\"${element.multiplechoices.Option_C}\",\"${element.multiplechoices.Option_D}\",${element.multiplechoices.CorrectAnswer});');
  //   });
  // }

  Fetch_all_table_names() async {
    var all_tables = [];
    var db = await openDatabase('QuizDb.db');
    var alltablesraw = await db
        .rawQuery('''SELECT type,name,tbl_name FROM "main".sqlite_master;''');
    alltablesraw.forEach((element) {
      if (element['type'] == 'table') {
        all_tables.add(element['tbl_name']);
      }
    });

    log(all_tables.toString());
    return alltablesraw;
  }

  Fetch_Quizs_names({level}) async {
    var all_tables = [];
    var rawdata;
    var db = await openDatabase('QuizDb.db');
    if (level != null) {
      rawdata = await db.query('Quizs', where: 'Level = $level');
    } else {
      rawdata = await db.query('Quizs');
    }
    rawdata.forEach((element) {
      all_tables.add([element['Name'], element['Level'], element['UrduName']]);
      log(element.toString());
    });

    return all_tables;
  }

  Future Fetch_Table_Data({table}) async {
    // log(table);
    List<QuizMainModel> all_tables = [];
    var db = await openDatabase('QuizDb.db');
    var rawdata = await db.query('\'$table\'');
    rawdata.forEach((element) {
      all_tables.add(QuizMainModel.fromMap(element));
    });

    return await all_tables;
  }

  Future Fetch_all_word_packs({level}) async {
    List<wordpackmodel> all_tables = [];
    var rawtablesdata;
    var db = await openDatabase('QuizDb.db');
    if (level != null) {
      rawtablesdata = await db.query('Quizs', where: 'Level = $level');
    } else {
      rawtablesdata = await db.query('Quizs');
    }
    rawtablesdata.forEach((element) {
      all_tables.add(wordpackmodel.fromMap(element));
    });

    return all_tables;
  }
}
