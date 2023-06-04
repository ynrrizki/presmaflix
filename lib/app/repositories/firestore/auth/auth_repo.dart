import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:google_sign_in/google_sign_in.dart' as googleAuth;
import 'package:presmaflix/app/models/user.dart';
import 'package:presmaflix/app/repositories/firestore/user/user_repo.dart';
import 'repository.dart';

class AuthRepository extends Repository {
  final firebaseAuth.FirebaseAuth _auth;
  final googleAuth.GoogleSignIn _googleSignIn;
  final UserRepository _userRepository;

  AuthRepository({
    firebaseAuth.FirebaseAuth? auth,
    googleAuth.GoogleSignIn? googleSignIn,
    required UserRepository userRepository,
  })  : _auth = auth ?? firebaseAuth.FirebaseAuth.instance,
        _googleSignIn =
            googleSignIn ?? googleAuth.GoogleSignIn.standard(scopes: ['email']),
        _userRepository = userRepository;

  // Mendapatkan stream dari perubahan pengguna saat ini
  @override
  Stream<firebaseAuth.User?> get user => _auth.userChanges();

  // Melakukan proses sign in dengan email dan password
  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
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
  Future<User> signInWithGoogle() async {
    try {
      // Melakukan sign in dengan akun Google
      final account = await _googleSignIn.signIn();
      User user;

      if (account != null) {
        // Mendapatkan informasi otentikasi dari akun Google
        final auth = await account.authentication;
        final credential = firebaseAuth.GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );

        // Melakukan sign in dengan kredensial Google ke Firebase
        await _auth.signInWithCredential(credential);

        // Membuat objek User dari data pengguna saat ini
        user = const User().copyWith(
          id: _auth.currentUser!.uid,
          avatar: _auth.currentUser!.photoURL!,
          name: _auth.currentUser!.displayName!,
          email: _auth.currentUser!.email!,
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

  // Melakukan proses sign up dengan nama, email, dan password
  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Membuat objek User dari data pengguna yang baru dibuat
      final user = User(
        id: userCredential.user!.uid,
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

  // Melakukan proses sign out
  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
