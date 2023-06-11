part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserByIdLoaded extends UserState {
  final User user;

  const UserByIdLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoaded extends UserState {
  final List<User> users;

  const UserLoaded({this.users = const <User>[]});

  @override
  List<Object> get props => [users];
}
