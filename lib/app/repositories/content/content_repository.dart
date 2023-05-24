import 'dart:async';
import 'dart:developer';

import 'package:presmaflix/app/models/content.dart';

class ContentRepository {
  final List<Content> _contents;
  ContentRepository({List<Content>? contents})
      : _contents = contents ?? Content.contents;

  Stream<List<Content>> getAllContents() async* {
    log('When add getAllContents', name: 'ContentRepository');
    yield _contents;
  }
}
