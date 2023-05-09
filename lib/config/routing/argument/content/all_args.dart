import 'package:presmaflix/app/models/content.dart';

class AllArguments {
  const AllArguments({
    required this.title,
    required this.contents,
  });
  final String title;
  final List<Content> contents;
}
