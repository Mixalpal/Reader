import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_application_1/data/store_book.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'library_book_state.dart';

class LibraryBookCubit extends Cubit<LibraryBookState> {
  LibraryBookCubit({
    required this.libraryBook,
    required this.storeBookRepository,
    required this.libraryBookRepository,
    required this.accountRepository,
  }) : super(LibraryBookInitial());

  final LibraryBook libraryBook;
  final StoreBookRepository storeBookRepository;
  final LibraryBookRepository libraryBookRepository;
  final AccountRepository accountRepository;

  void initialize() {
    final LibraryBookState newScreenState =
        state.copyWith(libraryBook: libraryBook);
    emit(newScreenState);
    getCover(newScreenState.libraryBook.imgLink);
  }

  void getCover(String imgLink) async {
    try {
      log('imgLink; $imgLink');
      final appDocDir =
          '/data/user/0/com.example.flutter_application_1/app_flutter/$imgLink';
      if (File(appDocDir).existsSync()) {
        File file = File(appDocDir);
        final newScreenState = state.copyWith(coverFile: file);
        emit(newScreenState);
        return;
      }
      log('File FOR SOME REASON does not exist');
      final file = await File(appDocDir).create();
      final gsReference = FirebaseStorage.instance
          .refFromURL("gs://dreamreader-aa940.appspot.com/bookCovers/$imgLink");
      final downloadTask = gsReference.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            // TODO: Handle this case.
            break;
          case TaskState.paused:
            // TODO: Handle this case.
            break;
          case TaskState.success:
            final newScreenState = state.copyWith(coverFile: file);
            emit(newScreenState);
            break;
          case TaskState.canceled:
            // TODO: Handle this case.
            break;
          case TaskState.error:
            // TODO: Handle this case.
            break;
        }
      });
    } on FirebaseException catch (e) {
      log('exception in imgLoading fuction: $e');
    }
  }
}
