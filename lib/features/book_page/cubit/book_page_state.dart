part of 'book_page_cubit.dart';

class BookPageState extends Equatable {
  const BookPageState({
    this.storeBook,
    this.reviews = const [],
    this.coverFile,
    this.status = Status.loading,
    this.rating = 1,
    this.reviewText = "",
  });

  final StoreBook? storeBook;
  final List<Review> reviews;
  final File? coverFile;
  final Status status;
  final int rating;
  final String reviewText;

  BookPageState copyWith({
    StoreBook? storeBook,
    List<Review>? reviews,
    File? coverFile,
    Status? status,
    int? rating,
    String? reviewText,
  }) {
    return BookPageState(
      storeBook: storeBook ?? this.storeBook,
      reviews: reviews ?? this.reviews,
      coverFile: coverFile ?? this.coverFile,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      reviewText: reviewText ?? this.reviewText,
    );
  }

  @override
  List<Object?> get props =>
      [storeBook, reviews, coverFile, status, rating, reviewText];
}

class BookPageInitial extends BookPageState {}

enum Status {
  loading,
  loaded,
}
