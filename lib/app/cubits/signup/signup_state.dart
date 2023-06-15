part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String name;
  final String email;
  final String password;
  final SignupStatus status;
  final String info;

  const SignupState({
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.info,
  });

  factory SignupState.initial() {
    return const SignupState(
      name: '',
      email: '',
      password: '',
      status: SignupStatus.initial,
      info: '',
    );
  }

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    SignupStatus? status,
    String? info
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      info: info ?? this.info,
    );
  }

  @override
  List<Object> get props => [name, email, password, status, info];
}
