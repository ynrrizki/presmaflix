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
    apiKey: 'AIzaSyC3xPI1yp8szj_CIkFy9QYKqUWU6dhGH7U',
    appId: '1:923273589990:web:b92c465cf7781c1ab33727',
    messagingSenderId: '923273589990',
    projectId: 'presmaflix',
    authDomain: 'presmaflix.firebaseapp.com',
    storageBucket: 'presmaflix.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQBP6VQb0yQENcdclCLxkayDsfWP4IO3Y',
    appId: '1:923273589990:android:32496b4bd86ba524b33727',
    messagingSenderId: '923273589990',
    projectId: 'presmaflix',
    storageBucket: 'presmaflix.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBBeN0j4btD1ARGilCv3ThUc7fmgCqDPQ',
    appId: '1:923273589990:ios:b427fbb7e25ef3f1b33727',
    messagingSenderId: '923273589990',
    projectId: 'presmaflix',
    storageBucket: 'presmaflix.appspot.com',
    iosClientId:
        '923273589990-hmls550h1ku7ofk8n1606sjo8b0oc638.apps.googleusercontent.com',
    iosBundleId: 'com.smkprestasiprima.presmaflix',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBBeN0j4btD1ARGilCv3ThUc7fmgCqDPQ',
    appId: '1:923273589990:ios:b427fbb7e25ef3f1b33727',
    messagingSenderId: '923273589990',
    projectId: 'presmaflix',
    storageBucket: 'presmaflix.appspot.com',
    iosClientId:
        '923273589990-hmls550h1ku7ofk8n1606sjo8b0oc638.apps.googleusercontent.com',
    iosBundleId: 'com.smkprestasiprima.presmaflix',
  );
}
