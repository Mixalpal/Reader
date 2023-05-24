import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb2_parse/fb2_parse.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_application_1/features/settings/settingsJson.dart';

part 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit({
    required this.libraryBook,
  }) : super(ReaderInitial());

  final LibraryBook libraryBook;

  void initialize() async {
    log('initialising starting reader state');

    log('reader state initialised');

    log('initial reader state emitted');
    SettingsJson settingsJson = await getSettings();
    final newScreenState = state.copyWith(
      bookId: libraryBook.id,
      bookName: libraryBook.name,
      bookAuthor: libraryBook.author,
      bookPath: libraryBook.fileLink,
      fontSize: 14,
      currentPage: 1,
      nightModeOn: false, //TODO: считывать из настроек
      appBarVisible: false,
      status: Status.loading,
      settings: settingsJson,
    );
    emit(newScreenState);
    log('emmiting settings state');
    getBook();
  }

  void getBook() async {
    try {
      log('getting book file');
      final gsReference = FirebaseStorage.instance.refFromURL(
          "gs://dreamreader-aa940.appspot.com/books/${libraryBook.fileLink}");
      final appDocDir =
          '/data/user/0/com.example.flutter_application_1/app_flutter/${libraryBook.fileLink}';
      //final filePath = "${appDocDir.path}/DreamReaderCovers/$imgLink";
      if (File(appDocDir).existsSync()) {
        FB2Book book = FB2Book(appDocDir);
        log('book file existed. Starting parsing');
        await book.parse();
        log('parsing finished');
        final newScreenState = state.copyWith(
          book: book,
          status: Status.loaded,
        );
        emit(newScreenState);
        log('new state with a parsed book emitted');
        return;
      }
      log('downloading book file');
      final file = await File(appDocDir).create();
      final downloadTask = gsReference.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            // TODO: Handle this case.
            break;
          case TaskState.paused:
            // TODO: Handle this case.
            break;
          case TaskState.success:
            log('file downloaded. Staring parsing');
            FB2Book book = FB2Book(appDocDir);
            await book.parse();
            log('book parsed');
            final newScreenState = state.copyWith(
              book: book,
              status: Status.loaded,
            );
            emit(newScreenState);
            log('new state with a parsed book emitted');
            return;
          case TaskState.canceled:
            // TODO: Handle this case.
            break;
          case TaskState.error:
            // TODO: Handle this case.
            break;
        }
      });
    } catch (e) {
      log('exception in imgLoading fuction: $e');
    }
  }

  Future<SettingsJson> getSettings() async {
    SettingsJson settingsJson = SettingsJson('Loading', 1, '', false);
    log('json font before create: ${settingsJson.font}');
    await settingsJson.create();
    log('json font after create: ${settingsJson.font}');
    return settingsJson;
  }

  void goBack() {
    log('goBack');
    if (state.currentPage == 0) {
      return;
    }
    final newScreenState = state.copyWith(currentPage: state.currentPage - 1);
    emit(newScreenState);
    log('goBack emitted');
  }

  void goForward() {
    log('goForward');
    if (state.currentPage == state.book!.body.sections!.length - 1) {
      return;
    }
    final newScreenState = state.copyWith(currentPage: state.currentPage + 1);
    emit(newScreenState);
    log('goForward emitted');
  }

  void menuClick() {
    final newScreenState = state.copyWith(appBarVisible: !state.appBarVisible);
    emit(newScreenState);
  }
}
