import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  final String id;
  final String contentId;
  final String userId;

  const Watchlist({
    required this.id,
    required this.contentId,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, contentId, userId];
}
