import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/repositories/firestore/user/user_repo.dart';
import 'package:presmaflix/app/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoading()) {
    on<UserEvent>((event, emit) {
      if (event is LoadUser) {
        _onLoaduserToState();
      } else if (event is UpdateUser) {
        _onUpdateUserToState(event, emit);
      }
    });

    on<EditUser>((event, emit) async {
      await _userRepository.updateUser(event.user);
    });
  }

  void _onLoaduserToState() {
    _userSubscription?.cancel();
    _userSubscription = _userRepository.getUser().listen((user) {
      return add(UpdateUser(user));
    });
  }

  void _onUpdateUserToState(
    UpdateUser event,
    Emitter<UserState> emit,
  ) {
    emit(UserLoaded(user: event.user));
  }

  @override
  Future<void> close() async {
    _userSubscription?.cancel();
    super.close();
  }
}
