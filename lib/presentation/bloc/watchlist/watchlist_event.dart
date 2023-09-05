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

class LoadIsWatchlistExists extends WatchlistEvent {
  final String contentId;
  final String userId;
  const LoadIsWatchlistExists(this.contentId, this.userId);

  @override
  List<Object> get props => [contentId, userId];
}

class UpdateIsWatchlistExists extends WatchlistEvent {
  final bool isExists;
  const UpdateIsWatchlistExists({required this.isExists});

  @override
  List<Object> get props => [isExists];
}

class AddWatchlist extends WatchlistEvent {
  // final Watchlist watchlist;
  final String contentId;
  final String userId;
  const AddWatchlist({required this.contentId, required this.userId});

  @override
  List<Object> get props => [contentId, userId];
}

class DeleteWatchlist extends WatchlistEvent {
  final String watchlistId;
  const DeleteWatchlist(this.watchlistId);

  @override
  List<Object> get props => [watchlistId];
}

class DeleteWatchlistByContentId extends WatchlistEvent {
  final String contentId;
  const DeleteWatchlistByContentId(this.contentId);

  @override
  List<Object> get props => [contentId];
}
