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
    apiKey: 'AIzaSyDF-ZfsxVSzISfXuSnXywaUla37I_8Sb7w',
    appId: '1:273486801160:web:8fe492f16ab9aa2549a4bd',
    messagingSenderId: '273486801160',
    projectId: 'sushiapp-18270',
    authDomain: 'sushiapp-18270.firebaseapp.com',
    storageBucket: 'sushiapp-18270.appspot.com',
    measurementId: 'G-QWML97XZVP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBae2sU9BAtLI5nJmvcGz94HKkalDjx7Zs',
    appId: '1:273486801160:android:e011aa769d62598949a4bd',
    messagingSenderId: '273486801160',
    projectId: 'sushiapp-18270',
    storageBucket: 'sushiapp-18270.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBURFdo2GUe7olnyAOYFBEOv7gsyGvWad8',
    appId: '1:273486801160:ios:012279c166ede14349a4bd',
    messagingSenderId: '273486801160',
    projectId: 'sushiapp-18270',
    storageBucket: 'sushiapp-18270.appspot.com',
    iosBundleId: 'com.example.cardgame',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBURFdo2GUe7olnyAOYFBEOv7gsyGvWad8',
    appId: '1:273486801160:ios:0468a8d42150cc1949a4bd',
    messagingSenderId: '273486801160',
    projectId: 'sushiapp-18270',
    storageBucket: 'sushiapp-18270.appspot.com',
    iosBundleId: 'com.example.cardgame.RunnerTests',
  );
}
