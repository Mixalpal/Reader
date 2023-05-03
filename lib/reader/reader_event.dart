part of 'reader_bloc.dart';

abstract class ReaderEvent {
  const ReaderEvent();
}

class ReaderNextPage extends ReaderEvent {
  const ReaderNextPage();
}

class ReaderPrevPage extends ReaderEvent {
  const ReaderPrevPage();
}

class ReaderGoToPage extends ReaderEvent {
  const ReaderGoToPage({required this.page});
  final int page;
}

class ReaderClose extends ReaderEvent {
  const ReaderClose();
}

class ReaderChangeMode extends ReaderEvent {
  const ReaderChangeMode();
}

class ReaderFontUp extends ReaderEvent {
  const ReaderFontUp();
}

class ReaderFontDown extends ReaderEvent {
  const ReaderFontDown();
}

class ReaderInitialize extends ReaderEvent {
  const ReaderInitialize({required this.filePath});
  final String filePath;
}
