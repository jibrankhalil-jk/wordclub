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

  inital_ssdb_creating() async {
    var databasesPath = await getDatabasesPath();

    var path = ("$databasesPath/QuizDb.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      // Make sure the parent directory exists
      try {
        await Directory(databasesPath).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      ByteData data = await rootBundle.load("assets/QuizDb.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true).then((value) {
        log('database saved in : ${value.path}');
      });
    } else {
      print("Opening existing database");
    }
// open the database
    // var db = await openDatabase(path, readOnly: true);

    // if (kIsWeb == false) {
    //   var dbdir = await getApplicationDocumentsDirectory();
    //   ByteData dbfile = await rootBundle.load('assets/QuizDb.db');
    //   Uint8List dbbytes =
    //       dbfile.buffer.asUint8List(dbfile.offsetInBytes, dbfile.lengthInBytes);

    //   await File("${dbdir.parent.path}/databases/QuizDb.db")
    //       .writeAsBytes(dbbytes);
    // }
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

  // Adding_Data_to_tables() async {
  //   Database db = await openDatabase('QuizDb.db');

  //   BeginersA.forEach((element) async {
  //     await db.rawQuery(
  //         'INSERT INTO \"main\".\"Beginners Part A\"  ( \"id\",\"word\",\"origin\",\"part_of_speech\",\"defination\",\"sentence\",\"pronunciation\",\"Mcq Question\",\"Mcq Option_A\",\"Mcq Option_B\",\"Mcq Option_C\",\"Mcq Option_D\",\"Mcq CorrectAnswer\",\"Mw Option A\",\"Mw Option B\",\"Mw Option C\",\"Mw Option D\",\"Mw CorrectAnswer\",\"Mc Option A\",\"Mc Option B\",\"Mc Option C\",\"Mc Option D\",\"Mc CorrectAnswer\"\) VALUES \(null, "${element.word}","${element.origin}","${element.part_of_speech}","${element.defination}","${element.sentence}","${element.pronunciation}","${element.multiplechoices.Mcq_Question}","${element.multiplechoices.Mcq_Option_A}","${element.multiplechoices.Mcq_Option_B}","${element.multiplechoices.Mcq_Option_C}","${element.multiplechoices.Mcq_Option_D}","${element.multiplechoices.Mcq_CorrectAnswer}","${element.Matchword.Mw_Option_A}","${element.Matchword.Mw_Option_B}","${element.Matchword.Mw_Option_C}","${element.Matchword.Mw_Option_D}","${element.Matchword.Mw_CorrectAnswer}","${element.SpellingMc.Mc_Option_A}","${element.SpellingMc.Mc_Option_B}","${element.SpellingMc.Mc_Option_C}","${element.SpellingMc.Mc_Option_D}","${element.SpellingMc.Mc_CorrectAnswer}");');
  //   });
  // }

  Fetch_all_table_names() async {
    var all_tables = [];
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    var db = await openDatabase(path, readOnly: true);
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
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    var db = await openDatabase(path, readOnly: true);
    if (level != null) {
      rawdata = await db.query('"Quizs"', where: 'Level = $level');
    } else {
      rawdata = await db.query('"Quizs"');
      log(rawdata.toString());
    }
    rawdata.forEach((element) {
      all_tables.add([element['Name'], element['Level'], element['UrduName']]);
    });
    return all_tables;
  }

  Future Fetch_Table_Data({table}) async {
    List<QuizMainModel> all_tables = [];
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    var db = await openDatabase(path,
        readOnly: true); // var rawdata = await db.query('\'$table\'');
    var rawdata = await db
        .rawQuery('SELECT "_rowid_",* FROM "main"."$table" LIMIT 0, 49999;');

    rawdata.forEach((element) {
      all_tables.add(QuizMainModel.fromMap(element));
    });
    // log('${rawdata[0].keys}');

    return await all_tables;
  }

  Future Fetch_all_word_packs({level}) async {
    List<wordpackmodel> all_tables = [];
    var rawtablesdata;
    // var db = await openDatabase('QuizDb.db');
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    var db = await openDatabase(path, readOnly: true);
    if (level != null) {
      // rawtablesdata = await db.query('Quizs', where: 'Level = $level');
      rawtablesdata = await db.rawQuery(
          '''SELECT * FROM "main"."Quizs" WHERE "Level" LIKE '%$level%' ;''');
    } else {
      // rawtablesdata = await db.query('Quizs');
      try {
        rawtablesdata = await db.rawQuery(
            '''SELECT "_rowid_",* FROM "main"."Quizs" LIMIT 0, 49999;''');
      } catch (e) {
        log(e.toString());
      }
    }
    rawtablesdata.forEach((element) {
      all_tables.add(wordpackmodel.fromMap(element));
    });

    return all_tables;
  }
}
