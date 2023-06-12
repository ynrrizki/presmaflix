part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlists extends WatchlistEvent {}

class UpdateWatchlists extends WatchlistEvent {
  final List<Watchlist> watchlists;
  const UpdateWatchlists(this.watchlists);

  @override
  List<Object> get props => [watchlists];
}
