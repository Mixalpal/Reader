import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'reader.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  late Reader _reader;
  late bool _nightModeOn;
  String filePath;

  ReaderBloc({required this.filePath})
      : super(ReaderInitial(
            "Название загружается", filePath, "Автор загружается", -1, false)) {
    _reader = Reader(filePath);
    on<ReaderNextPage>(_nextPage);
    on<ReaderPrevPage>(_prevPage);
    on<ReaderChangeMode>(_changeMode);
    on<ReaderGoToPage>(_goToPage);
    on<ReaderFontDown>(_fontDown);
    on<ReaderFontUp>(_fontUp);
    on<ReaderFontDown>(_fontDown);
    on<ReaderClose>(_close);
    on<ReaderInitialize>(_initialize);
  }

  void _nextPage(ReaderNextPage event, Emitter<ReaderState> emit) {}

  void _prevPage(ReaderPrevPage event, Emitter<ReaderState> emit) {}

  void _changeMode(ReaderChangeMode event, Emitter<ReaderState> emit) {}

  void _goToPage(ReaderGoToPage event, Emitter<ReaderState> emit) {}

  void _fontDown(ReaderFontDown event, Emitter<ReaderState> emit) {}

  void _fontUp(ReaderFontUp event, Emitter<ReaderState> emit) {}

  void _close(ReaderClose event, Emitter<ReaderState> emit) {}

  void _initialize(ReaderInitialize event, Emitter<ReaderState> emit) {}
}
