// import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:presmaflix/data/models/user/user.dart';

abstract class Repository {
  Stream<User> get user;

  Future<User> logInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signInWithGoogle();

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<void> signOut() async {}
}
