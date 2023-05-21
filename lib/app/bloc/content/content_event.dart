part of 'content_bloc.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class LoadContents extends ContentEvent {}

class UpdateContents extends ContentEvent {
  final List<Content> contents;
  const UpdateContents(this.contents);

  @override
  List<Object> get props => [contents];
}
