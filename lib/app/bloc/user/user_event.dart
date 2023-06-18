part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {}
class LoadUserById extends UserEvent {
  final String id;
  const LoadUserById({required this.id});

  @override
  List<Object> get props => [id];
}

class LoadUserByEmail extends UserEvent {
  final String email;
  const LoadUserByEmail({required this.email});

  @override
  List<Object> get props => [email];
}

class UpdateUser extends UserEvent {
  const UpdateUser(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class EditUser extends UserEvent {
  final User user;
  const EditUser({required this.user});

  @override
  List<Object> get props => [user];
}
