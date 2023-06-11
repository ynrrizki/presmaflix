part of 'logout_cubit.dart';

enum LogoutStatus { initial, enter, success, error }

class LogoutState extends Equatable {
  final LogoutStatus status;
  const LogoutState({required this.status,});

  factory LogoutState.initial() {
    return const LogoutState(
      status: LogoutStatus.initial,
    );
  }

  LogoutState copyWith({
    LogoutStatus? status,
  }) {
    return LogoutState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}