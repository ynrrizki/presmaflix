import 'package:presmaflix/app/models/content.dart';

class AllContentArguments {
  const AllContentArguments({
    required this.title,
    required this.contents,
  });
  final String title;
  final List<Content> contents;
}
