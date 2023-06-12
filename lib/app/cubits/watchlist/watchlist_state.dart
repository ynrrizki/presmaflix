part of 'watchlist_cubit.dart';


enum WatchlistStatus { initial, submitting, success, exists, notExists, error }

class WatchlistState extends Equatable {
  final WatchlistStatus status;

  const WatchlistState({
    required this.status,
  });

  factory WatchlistState.initial() {
    return const WatchlistState(
      status: WatchlistStatus.initial,
    );
  }

  WatchlistState copyWith({
    WatchlistStatus? status,
  }) {
    return WatchlistState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
