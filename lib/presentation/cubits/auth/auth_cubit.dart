import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/data/models/user/user.dart';
import 'package:presmaflix/data/repositories/firestore/auth/auth_repo.dart';
import 'package:presmaflix/data/repositories/firestore/user/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  // Melakukan proses sign in dengan email dan password
  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await _authRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // Melakukan proses sign in dengan akun Google
  void signInWithGoogle() async {
    try {
      emit(AuthLoading());
      await _authRepository.signInWithGoogle();
      emit(AuthGoogleSuccess());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // Melakukan proses sign up dengan email, password, nama, dan avatar (opsional)
  void signUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    String? avatar,
  }) async {
    try {
      avatar = 'https://ui-avatars.com/api/?name=$name';
      emit(AuthLoading());
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      emit(AuthSuccess());
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // Melakukan proses sign out
  void signOut() async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // Mendapatkan data pengguna berdasarkan ID
  void getCurrentUser(String id) async {
    try {
      final user = await UserRepository().getUserById(id);
      emit(AuthUser(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
