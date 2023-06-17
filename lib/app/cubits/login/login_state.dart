part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  submitting,
  loading,
  verify,
  notVerify,
  success,
  error
}

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String info;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.info = '',
  });

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      status: LoginStatus.initial,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? info,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      info: info ?? this.info,
    );
  }

  @override
  List<Object> get props => [email, password, status, info];
}
