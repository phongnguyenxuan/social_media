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
    apiKey: 'AIzaSyCVrKYS4pCL8Z52L80SqKr215offu4mYIk',
    appId: '1:1079302336547:web:e34d9d5ffec9486ecac196',
    messagingSenderId: '1079302336547',
    projectId: 'blog-1b935',
    authDomain: 'blog-1b935.firebaseapp.com',
    storageBucket: 'blog-1b935.appspot.com',
    measurementId: 'G-HTXKFQTSKX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJbE9qJD_n-BjUpyB9BZ-t6KAyRaxDACE',
    appId: '1:1079302336547:android:80fad55940c46e56cac196',
    messagingSenderId: '1079302336547',
    projectId: 'blog-1b935',
    storageBucket: 'blog-1b935.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgnlOt4XU1JiRJJPFJMZ8ozwUQewzSqz8',
    appId: '1:1079302336547:ios:0618a6fb9c2359a6cac196',
    messagingSenderId: '1079302336547',
    projectId: 'blog-1b935',
    storageBucket: 'blog-1b935.appspot.com',
    androidClientId: '1079302336547-ad9asjj0c4s4g9mtc71ciahsctfetb3h.apps.googleusercontent.com',
    iosClientId: '1079302336547-5n6rk2n3nerpb8319bffmulqgrd59erc.apps.googleusercontent.com',
    iosBundleId: 'com.example.blog',
  );
}
