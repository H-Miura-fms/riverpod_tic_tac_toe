// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCWnRieFsedimIvgsjNevAdUSb0dm1faY',
    appId: '1:807943088200:android:d989c8a1b020562321907d',
    messagingSenderId: '807943088200',
    projectId: 'tic-tac-toe-handson',
    storageBucket: 'tic-tac-toe-handson.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZHELrAr4SRfXLYrxc4zF27P0R3sGsbi0',
    appId: '1:807943088200:ios:125d7bfaa751582d21907d',
    messagingSenderId: '807943088200',
    projectId: 'tic-tac-toe-handson',
    storageBucket: 'tic-tac-toe-handson.appspot.com',
    iosBundleId: 'com.example.ticTacToeHandson',
  );
}
