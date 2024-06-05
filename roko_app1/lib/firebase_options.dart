// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAq8edV46ThXs521RFFGOyoYMxkC_87QB8',
    appId: '1:732801100368:web:5c94b8fff5092b9d2bbf55',
    messagingSenderId: '732801100368',
    projectId: 'roko-app-e422d',
    authDomain: 'roko-app-e422d.firebaseapp.com',
    storageBucket: 'roko-app-e422d.appspot.com',
    measurementId: 'G-J4GPY73D4V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBDLB1wSLVtEbPJeYpkpoChPeWI_ohT4lE',
    appId: '1:732801100368:android:1869e1b6e94c3d922bbf55',
    messagingSenderId: '732801100368',
    projectId: 'roko-app-e422d',
    storageBucket: 'roko-app-e422d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlJSd2TLLUkcilCUq25ChHOpkpSSqre3I',
    appId: '1:732801100368:ios:8ecb40fac2e325e92bbf55',
    messagingSenderId: '732801100368',
    projectId: 'roko-app-e422d',
    storageBucket: 'roko-app-e422d.appspot.com',
    iosBundleId: 'com.example.rokoApp1',
  );

}