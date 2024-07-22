import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcZj1XBtcHRDfgJHdAJ4iQhEeF5t4pcJk',
    appId: '1:1053549617342:android:ce2a8fe1de52ec4c327eef',
    messagingSenderId: '1053549617342',
    projectId: 'coffeeshop-6d3a1',
    storageBucket: 'coffeeshop-6d3a1.appspot.com',
  );
}
