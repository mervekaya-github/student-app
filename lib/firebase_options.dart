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
    apiKey: 'AIzaSyBeqsj8LwhOBM-Cyf63hWvLNUF28lJSksI',
    appId: '1:942781948774:web:af2746a1c7a9e3f494dea7',
    messagingSenderId: '942781948774',
    projectId: 'student-app-ed788',
    authDomain: 'student-app-ed788.firebaseapp.com',
    storageBucket: 'student-app-ed788.appspot.com',
    measurementId: 'G-L2WFY8C06B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1zg4MVl4mkyzr9SQ4lIziIxu8CzRFAuE',
    appId: '1:942781948774:android:eaf6d867ba2a853094dea7',
    messagingSenderId: '942781948774',
    projectId: 'student-app-ed788',
    storageBucket: 'student-app-ed788.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARjfun1NJ4p3BmRXNXJqoQEfdREDIqPSY',
    appId: '1:942781948774:ios:877e48f1ba8ecfc594dea7',
    messagingSenderId: '942781948774',
    projectId: 'student-app-ed788',
    storageBucket: 'student-app-ed788.appspot.com',
    iosBundleId: 'com.example.studentApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARjfun1NJ4p3BmRXNXJqoQEfdREDIqPSY',
    appId: '1:942781948774:ios:877e48f1ba8ecfc594dea7',
    messagingSenderId: '942781948774',
    projectId: 'student-app-ed788',
    storageBucket: 'student-app-ed788.appspot.com',
    iosBundleId: 'com.example.studentApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBeqsj8LwhOBM-Cyf63hWvLNUF28lJSksI',
    appId: '1:942781948774:web:08e818af912e317694dea7',
    messagingSenderId: '942781948774',
    projectId: 'student-app-ed788',
    authDomain: 'student-app-ed788.firebaseapp.com',
    storageBucket: 'student-app-ed788.appspot.com',
    measurementId: 'G-T1Z7BLPTX0',
  );
}