import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobServices {
  static String? get banneradduintid {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  static String? get Interstitialadduintid {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  static String? get Rewardedadduintid {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (ad) => print('add loaded'),
      onAdOpened: (ad) => print('add opend'),
      onAdClosed: (ad) => print('add closed'),
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        // add failed to load
      });
}
