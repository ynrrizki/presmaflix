import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/repositories/firestore/user/user_repo.dart';
import 'package:presmaflix/app/models/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUserById>(_onLoadUserById);
    on<UpdateUser>(_onUpdateUser);

    on<EditUser>((event, emit) async {
      await _userRepository.updateUser(event.user);
    });
  }

  void _onLoadUserById(LoadUserById event, Emitter<UserState> emit) {
    _userSubscription?.cancel();
    _userSubscription = _userRepository.getUser(uid: event.id).listen((user) {
      return add(UpdateUser(user));
    });
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    emit(UserByIdLoaded(user: event.user));
  }

  // void _onUpdateUserToState(
  //   UpdateUser event,
  //   Emitter<UserState> emit,
  // ) {
  //   emit(UserLoaded(user: event.user));
  // }

  @override
  Future<void> close() async {
    _userSubscription?.cancel();
    super.close();
  }
}
