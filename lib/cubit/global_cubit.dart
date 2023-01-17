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
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    // Check if the database exists
    var exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      //Creating new copy from asset
      try {
        // creating the dir
        await Directory(databasesPath.path).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      ByteData data = await rootBundle.load("assets/QuizDb.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // saving db from assets to app dir
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      // Opening existing database
    }
  }

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
    var db = await openDatabase(path, readOnly: true);
    var rawdata = await db
        .rawQuery('SELECT "_rowid_",* FROM "main"."$table" LIMIT 0, 49999;');
    rawdata.forEach((element) {
      all_tables.add(QuizMainModel.fromMap(element));
    });
    return await all_tables;
  }

  Future Fetch_all_word_packs({level}) async {
    List<wordpackmodel> all_tables = [];
    var rawtablesdata;
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    var db = await openDatabase(path, readOnly: true);
    if (level != null) {
      rawtablesdata = await db.rawQuery(
          '''SELECT * FROM "main"."Quizs" WHERE "Level" LIKE '%$level%' ;''');
    } else {
      rawtablesdata = await db.rawQuery(
          '''SELECT "_rowid_",* FROM "main"."Quizs" LIMIT 0, 49999;''');
    }
    rawtablesdata.forEach((element) {
      all_tables.add(wordpackmodel.fromMap(element));
    });
    return all_tables;
  }
}
