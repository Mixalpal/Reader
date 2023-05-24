part of 'reader_cubit.dart';

class ReaderState extends Equatable {
  const ReaderState({
    this.bookId = '',
    this.bookAuthor = '',
    this.bookName = '',
    this.bookPath = '',
    this.currentPage = 0,
    this.fontSize = 14,
    this.nightModeOn = false,
    this.appBarVisible = false,
    this.progress = 0,
    this.totalPages = 100,
    this.book,
    this.status = Status.loading,
    this.settings,
  });

  final String bookId;
  final String bookName;
  final String bookAuthor;
  final String bookPath;
  final double progress;
  final int fontSize;
  final int currentPage;
  final int totalPages;
  final bool nightModeOn;
  final bool appBarVisible;
  final FB2Book? book;
  final Status status;
  final SettingsJson? settings;

  ReaderState copyWith({
    String? bookId,
    String? bookName,
    String? bookAuthor,
    String? bookPath,
    double? progress,
    int? fontSize,
    int? currentPage,
    int? totalPages,
    bool? nightModeOn,
    bool? appBarVisible,
    FB2Book? book,
    Status? status,
    SettingsJson? settings,
  }) {
    return ReaderState(
      bookId: bookId ?? this.bookId,
      bookName: bookName ?? this.bookName,
      bookAuthor: bookAuthor ?? this.bookAuthor,
      bookPath: bookPath ?? this.bookPath,
      progress: progress ?? this.progress,
      fontSize: fontSize ?? this.fontSize,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      nightModeOn: nightModeOn ?? this.nightModeOn,
      appBarVisible: appBarVisible ?? this.appBarVisible,
      book: book ?? this.book,
      status: status ?? this.status,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [
        bookId,
        bookName,
        bookAuthor,
        bookPath,
        progress,
        fontSize,
        currentPage,
        totalPages,
        nightModeOn,
        appBarVisible,
        book,
        status,
        settings,
      ];
}

class ReaderInitial extends ReaderState {}

enum Status {
  loading,
  loaded,
}
