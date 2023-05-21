import 'dart:async';
import 'dart:developer';

import 'package:presmaflix/app/models/content.dart';

class ContentRepository {
  final List<Content> _contents;
  // final StreamController<List<Content>> _contentsController;

  // ContentRepository({List<Content>? contents})
  //     : _contents = contents ?? Content.contents,
  //       _contentsController = StreamController<List<Content>>.broadcast() {
  //   _contentsController.add(_contents);
  // }
  ContentRepository({List<Content>? contents})
      : _contents = contents ?? Content.contents;

  // Stream<List<Content>> getAllContents() {
  //   return _contentsController.stream;
  // }
  Stream<List<Content>> getAllContents() async* {
    log('When add getAllContents', name: 'ContentRepository');
    yield _contents;
  }
}
