part of 'search_cubit.dart';

enum SearchStatus { initial, changed, error }

class SearchState extends Equatable {
  final String name;
  final SearchStatus status;
  const SearchState({
    required this.name,
    required this.status,
  });

  factory SearchState.initial() {
    return const SearchState(
      name: '',
      status: SearchStatus.initial,
    );
  }

  SearchState copyWith({
    String? name,
    SearchStatus? status,
  }) {
    return SearchState(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, status];
}
