part of 'library_book_cubit.dart';

class LibraryBookState extends Equatable {
  const LibraryBookState({
    this.libraryBook = const LibraryBook(
      storeBookId: '',
      fileLink: '',
      imgLink: '',
      author: '',
      progress: 0,
      name: '',
    ),
    this.coverFile,
  });

  final LibraryBook libraryBook;
  final File? coverFile;

  LibraryBookState copyWith({
    LibraryBook? libraryBook,
    File? coverFile,
  }) {
    return LibraryBookState(
      libraryBook: libraryBook ?? this.libraryBook,
      coverFile: coverFile ?? this.coverFile,
    );
  }

  @override
  List<Object?> get props => [libraryBook, coverFile];
}

class LibraryBookInitial extends LibraryBookState {}
