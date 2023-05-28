import 'package:presmaflix/app/models/content.dart';

class ContentAllArguments {
  const ContentAllArguments({
    required this.title,
    required this.contents,
  });
  final String title;
  final List<Content> contents;
}
