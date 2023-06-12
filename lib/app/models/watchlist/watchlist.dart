import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Watchlist.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot;
    return Watchlist(
      id: data.id,
      contentId: data['contentId'],
      userId: data['userId'],
    );
  }

  Watchlist copyWith({
    String? id,
    String? contentId,
    String? userId,
  }) {
    return Watchlist(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [id, contentId, userId];
}
