part of 'reader_bloc.dart';

abstract class ReaderState extends Equatable {
  const ReaderState(
    this.text,
    this.filePath,
    this.author,
    this.page,
    this.nightModeOn,
  );

  final String text;
  final String filePath;
  final String author;
  final int page;
  final bool nightModeOn;

  @override
  List<Object> get props => [text, filePath, author, page, nightModeOn];
}

class ReaderInitialized extends ReaderState {
  const ReaderInitialized(
      super.text, super.filePath, super.author, super.page, super.nightModeOn);
}

class ReaderInitial extends ReaderState {
  const ReaderInitial(
      super.text, super.filePath, super.author, super.page, super.nightModeOn);
}

class ReaderLoading extends ReaderState {
  const ReaderLoading(
      super.text, super.filePath, super.author, super.page, super.nightModeOn);
}
