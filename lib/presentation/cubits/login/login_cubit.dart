import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:presmaflix/app/bloc/app/app_bloc.dart';
import 'package:presmaflix/data/repositories/firestore/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: LoginStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: LoginStatus.initial,
      ),
    );
  }

  Future<void> logInWithCredentials(bool validate) async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    if (validate) {
      emit(state.copyWith(status: LoginStatus.logInWithCredentials));
      try {
        await _authRepository.logInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(status: LoginStatus.success));

        final user = auth.FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.reload();
          log('${user.emailVerified}', name: 'LoginCubit');
          if (!user.emailVerified) {
            emit(state.copyWith(status: LoginStatus.notVerify));
          } else {
            emit(state.copyWith(status: LoginStatus.verify));
          }
        }

        emit(state.copyWith(
          email: '',
          password: '',
          status: LoginStatus.initial,
        ));
        // final isVerified = await _authRepository.isVerify;
        // if (!isVerified) {
        //   emit(state.copyWith(status: LoginStatus.notVerify));
        // } else {
        //   emit(state.copyWith(status: LoginStatus.verify));
        // }
      } on auth.FirebaseAuthException catch (e) {
        //   f (err.code == 'wrong-password') {
        //   res = 'Password Salah';
        // } else if (err.code == 'invalid-email') {
        //   res = 'Email Salah';
        // } else if (err.code == 'user-disabled') {
        //   res = 'Akun telah dinonaktifkan. Harap hubungi administrator';
        // } else if (err.code == 'user-not-found') {
        //   res = 'Tidak ada akun yang terdaftar dengan email tersebut';
        // }
        String errorMessage = 'unknown';
        if (e.code == 'wrong-password') {
          errorMessage = 'Password kamu salah, coba inget-inget lagi';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Email kamu tidak valid, gunakan @';
        } else if (e.code == 'user-disabled') {
          errorMessage =
              'Akun kamu telah dibanned sama admin, abis ngapain hayo?';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'Akun tidak terdaftar, daftar dulu ya lain kali!';
        }

        emit(state.copyWith(
            info: errorMessage != 'unknown' ? errorMessage : e.message,
            status: LoginStatus.error));
      }
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.submitting));
    emit(state.copyWith(status: LoginStatus.signInWithGoogle));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        log('${user.emailVerified}', name: 'LoginCubit');
        if (!user.emailVerified) {
          emit(state.copyWith(status: LoginStatus.notVerify));
        } else {
          emit(state.copyWith(status: LoginStatus.verify));
        }
      }
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan signIn dengan Google.';
      if (e is auth.FirebaseException) {
        errorMessage = '${e.message}';
      }
      emit(state.copyWith(info: errorMessage, status: LoginStatus.error));
    }
  }
}
