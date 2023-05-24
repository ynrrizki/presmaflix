import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final String id;
  final String contentId;

  const Media({
    required this.id,
    required this.contentId,
  });

  @override
  List<Object?> get props => [
        id,
        contentId,
      ];

  static List<Media> media = const [
    Media(
      id: '1',
      contentId: '1',
    ),
    Media(
      id: '2',
      contentId: '2',
    ),
    Media(
      id: '3',
      contentId: '3',
    ),
    Media(
      id: '4',
      contentId: '4',
    ),
    Media(
      id: '5',
      contentId: '5',
    ),
    Media(
      id: '6',
      contentId: '6',
    )
  ];
}
