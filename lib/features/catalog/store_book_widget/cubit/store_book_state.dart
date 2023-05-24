part of 'store_book_cubit.dart';

class StoreBookState extends Equatable {
  const StoreBookState({
    this.storeBook = const StoreBook(
        id: '',
        annotation: '',
        author: '',
        avgScore: 5,
        fileLink: '',
        name: '',
        price: 500,
        reviewsIdList: [],
        tagIdList: []),
    this.coverFile,
  });

  final StoreBook storeBook;
  final File? coverFile;

  StoreBookState copyWith({StoreBook? storeBook, File? coverFile}) {
    return StoreBookState(
      storeBook: storeBook ?? this.storeBook,
      coverFile: coverFile ?? this.coverFile,
    );
  }

  @override
  List<Object?> get props => [storeBook, coverFile];
}

class StoreBookInitial extends StoreBookState {}
