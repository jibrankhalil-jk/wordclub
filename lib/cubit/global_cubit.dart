import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soundpool/soundpool.dart';
import 'package:sqflite/sqflite.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:wordclub/data/beginers.dart';
import 'package:wordclub/services/admobads.dart';

import '../models/database_main_model.dart';
import '../models/wordpackmodel.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final GetStorage _getStorage = GetStorage();
  GlobalCubit() : super(GlobalInitial());
  TextToSpeech tts = TextToSpeech();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  InterstitialAd? _interstitialAd;

  Locale app_language =
      GetStorage().read('App_Language') == 'en' ? Locale('en') : Locale('ur');

  updatebookmarks(data) async {
    List bookmarks = _getStorage.read('bookmarks');
    bookmarks.addAll(data);
    await _getStorage.write('bookmarks', bookmarks);
  }

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
    List<String>? allTables;
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    var db = await openDatabase(path, readOnly: true);
    var alltablesraw = await db
        .rawQuery('''SELECT type,name,tbl_name FROM "main".sqlite_master;''');
    for (var element in alltablesraw) {
      if (element['type'] == 'table') {
        allTables!.add(element['tbl_name'].toString());
      }
    }
    return allTables;
  }

  Fetch_Quizs_names({level}) async {
    var allTables = [];
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
      allTables.add([element['Name'], element['Level'], element['UrduName']]);
    });
    return allTables;
  }

  Future Fetch_Table_Data({table, type}) async {
    var type = await _getStorage.read('App_Language');

    List<QuizMainModel> allTables = [];
    List allLocalTables = [];
    var rawdata;
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = ("${databasesPath.path}/QuizDb.db");
    var db = await openDatabase(path, readOnly: true);

    try {
      var rawlocaltables =
          await db.rawQuery('''SELECT type,name FROM "main".sqlite_master ;''');
      rawlocaltables.forEach((element) {
        allLocalTables.add(element['name'].toString());
      });
    } catch (e) {}

    if (allLocalTables!.contains(table)) {
      log('local table');
      rawdata = await db
          .rawQuery('SELECT "_rowid_",* FROM "main"."$table" LIMIT 0, 49999;');
      for (var element in rawdata) {
        allTables.add(QuizMainModel.fromMap(element));
      }
    } else {
      log('firebase table');
      var firebaserawData = await _firebaseFirestore
          .collection('Quizs')
          .doc('$table')
          .collection('${type == 'en' ? 'EnglishTableNAme' : 'UrduTableNAme'}')
          .get();
      firebaserawData.docs.forEach((element) {
        allTables.add(QuizMainModel.fromMap(element.data()));
      });
    }

    return await allTables;
  }

  Future Fetch_all_word_packs({level}) async {
    List<wordpackmodel> allTables = [];
    var rawtablesdata;
    var firebasetablse;

    log('running');

    try {
      if (level != null) {
        firebasetablse = await _firebaseFirestore
            .collection('Quizs')
            .where('LevelTableNAme', isEqualTo: '$level')
            .get();
        log(firebasetablse.docs.toString());
        log(level);
      } else {
        firebasetablse = await _firebaseFirestore.collection('Quizs').get();
      }
    } catch (e) {}
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
      allTables.add(wordpackmodel.fromMap(element));
    });
    try {
      firebasetablse.docs.forEach((element) {
        log(element.data().toString());
        allTables.add(wordpackmodel(
            level: element.data()['LevelTableNAme'],
            urduname: element.data()['UrduTableNAme'],
            title: element.data()['EnglishTableNAme']));
      });
    } catch (e) {}

    return allTables;
  }

  // getting_new_words_from_firebase() async {
  //   var fbtables = await _firebaseFirestore.collection('Quizs').get();
  //   fbtables.docs.forEach((element) {

  //   });
  // }

  play_tick_sound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId =
        await rootBundle.load("assets/tick.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }

  showfulladd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createinterestialadd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createinterestialadd();
      });
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void _createinterestialadd() {
    InterstitialAd.load(
        adUnitId: AdMobServices.Interstitialadduintid!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => _interstitialAd = ad,
            onAdFailedToLoad: (error) => _interstitialAd = null));
  }
}
