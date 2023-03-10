// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyARBzoSenQ7g9Jw4cKNVcr0CrCdJ0t1YXg',
    appId: '1:759520270291:web:b49cb9293188e557470126',
    messagingSenderId: '759520270291',
    projectId: 'wordclub-1358c',
    authDomain: 'wordclub-1358c.firebaseapp.com',
    storageBucket: 'wordclub-1358c.appspot.com',
    measurementId: 'G-QV47YB1WSJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZ-VmxpIHfw1QxoYW4lnE6sMFol5IVo8E',
    appId: '1:759520270291:android:b25cb15939394060470126',
    messagingSenderId: '759520270291',
    projectId: 'wordclub-1358c',
    storageBucket: 'wordclub-1358c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKEq3IRO70SNgPyu2jfQhPDQag9anQDxw',
    appId: '1:759520270291:ios:ce807ac2a06b09a0470126',
    messagingSenderId: '759520270291',
    projectId: 'wordclub-1358c',
    storageBucket: 'wordclub-1358c.appspot.com',
    iosClientId: '759520270291-04kotfri6u86v6b76716rpfpabtug66k.apps.googleusercontent.com',
    iosBundleId: 'com.jasolangi.wordclub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKEq3IRO70SNgPyu2jfQhPDQag9anQDxw',
    appId: '1:759520270291:ios:ce807ac2a06b09a0470126',
    messagingSenderId: '759520270291',
    projectId: 'wordclub-1358c',
    storageBucket: 'wordclub-1358c.appspot.com',
    iosClientId: '759520270291-04kotfri6u86v6b76716rpfpabtug66k.apps.googleusercontent.com',
    iosBundleId: 'com.jasolangi.wordclub',
  );
}
