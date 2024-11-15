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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCeTQ0x5Xd_RanvNwoQhztj6nkyRiP2MJk',
    appId: '1:658153566059:web:8a8651e1719a57a407e62e',
    messagingSenderId: '658153566059',
    projectId: 'chad-ai-27020',
    authDomain: 'chad-ai-27020.firebaseapp.com',
    storageBucket: 'chad-ai-27020.firebasestorage.app',
    measurementId: 'G-LMZ9R3Y5GM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3aHh-M-uPER-qt1gaLgSHy5yEXvhn57k',
    appId: '1:658153566059:android:fddb95dbb1c698db07e62e',
    messagingSenderId: '658153566059',
    projectId: 'chad-ai-27020',
    storageBucket: 'chad-ai-27020.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtFOG4FRWD1wVQeeQhSV5F3GKP3pfQgJc',
    appId: '1:658153566059:ios:09e8984f58faf54307e62e',
    messagingSenderId: '658153566059',
    projectId: 'chad-ai-27020',
    storageBucket: 'chad-ai-27020.firebasestorage.app',
    iosBundleId: 'com.example.chadAi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtFOG4FRWD1wVQeeQhSV5F3GKP3pfQgJc',
    appId: '1:658153566059:ios:09e8984f58faf54307e62e',
    messagingSenderId: '658153566059',
    projectId: 'chad-ai-27020',
    storageBucket: 'chad-ai-27020.firebasestorage.app',
    iosBundleId: 'com.example.chadAi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCeTQ0x5Xd_RanvNwoQhztj6nkyRiP2MJk',
    appId: '1:658153566059:web:928e3a364e948dd907e62e',
    messagingSenderId: '658153566059',
    projectId: 'chad-ai-27020',
    authDomain: 'chad-ai-27020.firebaseapp.com',
    storageBucket: 'chad-ai-27020.firebasestorage.app',
    measurementId: 'G-L8HQ1N5FM7',
  );
}
