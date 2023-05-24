part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final List<Content> contents;

  const ContentLoaded({this.contents = const <Content>[]});

  @override
  List<Object> get props => [contents];
}
