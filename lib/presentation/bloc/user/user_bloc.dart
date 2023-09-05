import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/data/repositories/firestore/user/user_repo.dart';
import 'package:presmaflix/data/models/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;
  StreamSubscription? _userEmailSubscription;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUserById>(_onLoadUserById);
    on<LoadUserByEmail>(_onLoadUserByEmail);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateAvatar>(_onUpdateAvatar);

    on<EditUser>((event, emit) async {
      await _userRepository.updateUser(event.user);
    });

    on<DeleteUser>((event, emit) async {
      await _userRepository.deleteUser();
    });
  }

  void _onLoadUserById(LoadUserById event, Emitter<UserState> emit) {
    _userSubscription?.cancel();
    _userSubscription = _userRepository.getUser(uid: event.id).listen((user) {
      return add(UpdateUser(user));
    });
  }

  void _onLoadUserByEmail(LoadUserByEmail event, Emitter<UserState> emit) {
    _userEmailSubscription?.cancel();
    _userEmailSubscription = _userRepository
        .getUserAvatarByEmail(email: event.email)
        .listen((avatar) {
      log(event.email, name: 'user_bloc ');
      return add(UpdateAvatar(avatar!));
    });
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    emit(UserByIdLoaded(user: event.user));
  }

  void _onUpdateAvatar(UpdateAvatar event, Emitter<UserState> emit) {
    emit(UserAvatarLoaded(avatar: event.avatar));
  }

  @override
  Future<void> close() async {
    _userSubscription?.cancel();
    _userEmailSubscription?.cancel();
    super.close();
  }
}
