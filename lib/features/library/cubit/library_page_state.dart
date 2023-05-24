part of 'library_page_cubit.dart';

class LibraryState extends Equatable {
  const LibraryState({
    this.libraryBooks = const [],
    this.filters = const Filters(),
    this.isLoading = true,
  });

  final List<LibraryBook> libraryBooks;
  final Filters filters;
  final bool isLoading;

  LibraryState copyWith({
    List<LibraryBook>? libraryBooks,
    Filters? filters,
    bool? isLoading,
  }) {
    return LibraryState(
      libraryBooks: libraryBooks ?? this.libraryBooks,
      filters: filters ?? this.filters,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [libraryBooks, filters];
}

class LibraryInitial extends LibraryState {}

class Filters {
  const Filters();
}
