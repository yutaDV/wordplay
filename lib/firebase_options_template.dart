import 'package:firebase_core/firebase_core.dart';

class FirebaseOptionsTemplate {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAwyd5mocfsa2cjS5l0s5Y4ayUQx8X-kX8',
    appId: '1:340569211116:web:b045e6a5a2a88ebc7ca5c9',
    messagingSenderId: '340569211116',
    projectId: 'wordplay-6fd2a',
    authDomain: 'wordplay-6fd2a.firebaseapp.com',
    storageBucket: 'wordplay-6fd2a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDT_QAaUN-C80_pmJysfR9niy2UzSo7DMs',
    appId: '1:340569211116:android:c3fddc9911ce1d977ca5c9',
    messagingSenderId: '340569211116',
    projectId: 'wordplay-6fd2a',
    storageBucket: 'wordplay-6fd2a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdOtqkz9zo09E8ajYZb5QEOgzapjbUCu0',
    appId: '1:340569211116:ios:78f27666ace4c66d7ca5c9',
    messagingSenderId: '340569211116',
    projectId: 'wordplay-6fd2a',
    storageBucket: 'wordplay-6fd2a.appspot.com',
    iosBundleId: 'com.example.wordplay',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdOtqkz9zo09E8ajYZb5QEOgzapjbUCu0',
    appId: '1:340569211116:ios:9f61c6348561d6477ca5c9',
    messagingSenderId: '340569211116',
    projectId: 'wordplay-6fd2a',
    storageBucket: 'wordplay-6fd2a.appspot.com',
    iosBundleId: 'com.example.wordplay.RunnerTests',
  );
}
