import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:presmaflix/app/bloc/app/app_bloc.dart';
import 'package:presmaflix/app/repositories/firestore/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  // final AppBloc _appBloc;
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

  Future<void> logInWithCredentials() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
      emit(state.copyWith(
        email: '',
        password: '',
        status: LoginStatus.initial,
      ));
      log('${_authRepository.isVerify!}', name: 'LoginCubit');
      if (_authRepository.isVerify!) {
        emit(state.copyWith(status: LoginStatus.verify));
      } else {
        emit(state.copyWith(status: LoginStatus.notVerify));
      }
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan saat mendaftar.';
      if (e is auth.FirebaseException) {
        errorMessage = '${e.message}';
      }
      emit(state.copyWith(info: errorMessage, status: LoginStatus.error));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } catch (_) {}
  }
}
