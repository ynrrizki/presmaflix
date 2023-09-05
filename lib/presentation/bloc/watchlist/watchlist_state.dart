part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Watchlist> watchlists;

  const WatchlistLoaded({this.watchlists = const <Watchlist>[]});

  @override
  List<Object> get props => [watchlists];
}

class IsWatchlistExistsLoaded extends WatchlistState {
  final bool isExists;
  const IsWatchlistExistsLoaded({required this.isExists});

  @override
  List<Object> get props => [isExists];
}
