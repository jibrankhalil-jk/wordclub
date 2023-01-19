import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localization/localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';
import 'package:wordclub/services/admobads.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // admob integration
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  var _rewaredescore = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _createBannerAd();
    _createinterestialadd();
    _createrewardedadd();
  }

  initialdbcreating() async {
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

  void _createBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobServices.banneradduintid!,
        listener: AdMobServices.bannerAdListener,
        request: AdRequest())
      ..load();
  }

  void _createinterestialadd() {
    InterstitialAd.load(
        adUnitId: AdMobServices.Interstitialadduintid!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => _interstitialAd = ad,
            onAdFailedToLoad: (error) => _interstitialAd = null));
  }

  void _createrewardedadd() {
    RewardedAd.load(
        adUnitId: AdMobServices.Rewardedadduintid!,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => _rewardedAd = ad,
            onAdFailedToLoad: (error) => _rewardedAd = null));
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

  showrewardedadd() {
    if (_interstitialAd != null) {
      _rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createrewardedadd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createrewardedadd();
      });
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) => _rewaredescore++);
      _rewardedAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var buttonswidth = MediaQuery.of(context).size.width / 1.5;
    var buttonsheight = MediaQuery.of(context).size.height / 9.5;
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(AppAssets().background_illustration)),
              SafeArea(
                child: Center(
                    child: Column(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Word Club',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: AppPrimaryColor),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/Start_Quiz'),
                        child: Container(
                          width: buttonswidth,
                          height: buttonsheight,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                AppAssets().quiz_button,
                                fit: BoxFit.fill,
                              ),
                              Center(
                                  child: Text(
                                'Start Quiz'.i18n(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20,
                                    fontWeight: FontWeight.w400),
                              ))
                            ],
                          ),
                        )),
                    Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/Bookmarks'),
                        child: Container(
                          width: buttonswidth,
                          height: buttonsheight,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                AppAssets().regular_quiz_button,
                                fit: BoxFit.fill,
                              ),
                              Center(
                                  child: Text(
                                'Bookmarks'.i18n(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20,
                                    fontWeight: FontWeight.w400),
                              ))
                            ],
                          ),
                        )),
                    Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/History'),
                        child: Container(
                          width: buttonswidth,
                          height: buttonsheight,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                AppAssets().regular_quiz_button,
                                fit: BoxFit.fill,
                              ),
                              Center(
                                  child: Text(
                                'History'.i18n(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20,
                                    fontWeight: FontWeight.w400),
                              ))
                            ],
                          ),
                        )),
                    Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/Settings'),
                        child: Container(
                          width: buttonswidth,
                          height: buttonsheight,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                AppAssets().regular_quiz_button,
                                fit: BoxFit.fill,
                              ),
                              Center(
                                  child: Text(
                                'Settings'.i18n(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20,
                                    fontWeight: FontWeight.w400),
                              ))
                            ],
                          ),
                        )),
                    Spacer(
                      flex: 5,
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
        bottomNavigationBar: _bannerAd == null
            ? Container()
            : Container(
                height: 52,
                margin: EdgeInsets.only(bottom: 12),
                child: AdWidget(
                  ad: _bannerAd!,
                ),
              ));
  }
}
