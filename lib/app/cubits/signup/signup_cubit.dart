import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/services.dart';
import 'package:presmaflix/app/repositories/firestore/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'dart:developer';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit(this._authRepository) : super(SignupState.initial());

  void nameChanged(String value) {
    emit(
      state.copyWith(
        name: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: SignupStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: SignupStatus.initial,
      ),
    );
  }

  Future<void> signUpFormSubmitted(bool validate) async {
    if (state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    if (validate) {
      try {
        await _authRepository.signUp(
          name: state.name,
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(status: SignupStatus.success));
        log(state.status.toString());
      } catch (e) {
        String errorMessage = 'Terjadi kesalahan saat mendaftar.';
        if (e is auth.FirebaseException) {
          errorMessage = '${e.message}';
        }
        emit(state.copyWith(info: errorMessage, status: SignupStatus.error));
        log(state.status.toString());
      }
    }
  }
}
