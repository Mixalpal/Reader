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
    apiKey: 'AIzaSyBZAxXAMQ02ag8kCJm8VY3yhwDlni8hThc',
    appId: '1:887081821853:web:90af35c2cfb1965f509674',
    messagingSenderId: '887081821853',
    projectId: 'dreamreader-aa940',
    authDomain: 'dreamreader-aa940.firebaseapp.com',
    storageBucket: 'dreamreader-aa940.appspot.com',
    measurementId: 'G-W7W5EZY3SM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArM9WfQzYh-JazQnZUDzehZukKiukcUNw',
    appId: '1:887081821853:android:e4813a60ce68bc6e509674',
    messagingSenderId: '887081821853',
    projectId: 'dreamreader-aa940',
    storageBucket: 'dreamreader-aa940.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7Sfe6J9F2X5Vbd5-7JsgvtxfgkWmAhoU',
    appId: '1:887081821853:ios:964a88d15f81a174509674',
    messagingSenderId: '887081821853',
    projectId: 'dreamreader-aa940',
    storageBucket: 'dreamreader-aa940.appspot.com',
    iosClientId: '887081821853-22kt5eeh0nc92j2f1tv3n77g4t2se9ji.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7Sfe6J9F2X5Vbd5-7JsgvtxfgkWmAhoU',
    appId: '1:887081821853:ios:964a88d15f81a174509674',
    messagingSenderId: '887081821853',
    projectId: 'dreamreader-aa940',
    storageBucket: 'dreamreader-aa940.appspot.com',
    iosClientId: '887081821853-22kt5eeh0nc92j2f1tv3n77g4t2se9ji.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
