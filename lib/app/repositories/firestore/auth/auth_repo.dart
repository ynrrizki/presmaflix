import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart' as google_auth;
import 'package:presmaflix/app/models/user/user.dart';
import 'package:presmaflix/app/repositories/firestore/user/user_repo.dart';
import 'repository.dart';

class AuthRepository extends Repository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final google_auth.GoogleSignIn _googleSignIn;
  final UserRepository _userRepository;

  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    google_auth.GoogleSignIn? googleSignIn,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            google_auth.GoogleSignIn.standard(scopes: ['email']),
        _userRepository = userRepository;

  var currentUser = User.empty;

  bool? get isVerify {
    final user = _firebaseAuth.currentUser!;
    user.reload();
    return user.emailVerified;
  }

  // Mendapatkan stream dari perubahan pengguna saat ini
  // @override
  // Stream<User> get user => _firebaseAuth.authStateChanges().map((firebaseUser) {
  //       log('user: ${firebaseUser == null ? 'unauthenticated' : 'authenticated'}',
  //           name: 'AuthRepository');
  //       final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
  //       currentUser = user;
  //       return user;
  //     });

  @override
  Stream<User> get user =>
      _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
        log('user: ${firebaseUser == null ? 'unauthenticated' : 'authenticated'}',
            name: 'AuthRepository');

        if (firebaseUser == null) {
          currentUser = User.empty;
        } else {
          try {
            final user = await _userRepository.getUserById(firebaseUser.uid);
            currentUser = user;
          } catch (e) {
            signOut();
            log('Error fetching user: $e', name: 'AuthRepository');
            currentUser = User.empty;
          }
        }

        return currentUser;
      });

  // Melakukan proses sign up dengan nama, email, dan password
  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Membuat objek User dari data pengguna yang baru dibuat
      final user = User(
        id: userCredential.user!.uid,
        avatar: 'https://ui-avatars.com/api/?name=$name',
        name: name,
        email: email,
      );

      // Membuat pengguna di repository
      await _userRepository.createUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Melakukan proses sign in dengan email dan password
  @override
  Future<User> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mengambil data pengguna dari repository
      final user = await _userRepository.getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Melakukan proses sign in dengan akun Google
  @override
  Future<User> signInWithGoogle({bool destroy = false}) async {
    try {
      // Melakukan sign in dengan akun Google
      final account = await _googleSignIn.signIn();
      User user;

      if (account != null) {
        // Mendapatkan informasi otentikasi dari akun Google
        final auth = await account.authentication;
        final credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );

        // Melakukan sign in dengan kredensial Google ke Firebase
        await _firebaseAuth.signInWithCredential(credential);

        // Membuat objek User dari data pengguna saat ini
        user = const User().copyWith(
          id: _firebaseAuth.currentUser!.uid,
          avatar: _firebaseAuth.currentUser!.photoURL!,
          name: _firebaseAuth.currentUser!.displayName!,
          email: _firebaseAuth.currentUser!.email!,
        );

        // Membuat pengguna di repository jika belum ada
        await _userRepository.createUser(user);
      } else {
        // Membuat objek User dengan ID akun Google jika tidak ada akun yang dipilih
        user = const User().copyWith(id: account!.id);
      }

      return user;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed sign in with Google');
    }
  }

  // Melakukan proses sign out
  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      rethrow;
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
      avatar: photoURL,
    );
  }
}
