import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/bloc/app/app_bloc.dart';
import 'package:presmaflix/app/repositories/firestore/auth/auth_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository _authRepository;
  final AppBloc _appBloc;
  LogoutCubit(this._authRepository, this._appBloc)
      : super(LogoutState.initial());

  Future<void> logOut() async {
    if (state.status == LogoutStatus.enter) return;
    emit(state.copyWith(status: LogoutStatus.enter));
    try {
      await _authRepository.signOut();
      emit(state.copyWith(status: LogoutStatus.success));
      // _appBloc.add(AppUserChanged(_authRepository.currentUser));
    } on Exception {
      emit(state.copyWith(status: LogoutStatus.error));
    }
  }
}
