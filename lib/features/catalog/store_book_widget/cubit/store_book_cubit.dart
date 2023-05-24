import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_application_1/data/store_book.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

part 'store_book_state.dart';

Reference get firebaseStorage => FirebaseStorage.instance.ref();

class StoreBookCubit extends Cubit<StoreBookState> {
  StoreBookCubit({
    required this.storeBook,
    required this.storeBookRepository,
    required this.libraryBookRepository,
    required this.accountRepository,
  }) : super(StoreBookInitial());

  final StoreBook storeBook;
  final StoreBookRepository storeBookRepository;
  final LibraryBookRepository libraryBookRepository;
  final AccountRepository accountRepository;

  void initialize() async {
    StoreBook storeBookInitialized = storeBook.copyWith(
      bought: checkIfbought(),
    );
    final newScreenState = state.copyWith(storeBook: storeBookInitialized);
    emit(newScreenState);
    getCover(storeBookInitialized.imgLink!);
  }

  void buy(StoreBook storeBook) async {
    LibraryBook libraryBook = LibraryBook(
      storeBookId: storeBook.id!,
      fileLink: storeBook.fileLink,
      imgLink: storeBook.imgLink!,
      author: storeBook.author,
      progress: 0,
      name: storeBook.name,
    );
    storeBook = storeBook.copyWith(
      bought: true,
    );
    String id = libraryBookRepository.createBook(libraryBook);
    accountRepository.buyABook(id, storeBook.id);
    final newScreenState = state.copyWith(storeBook: storeBook);
    emit(newScreenState);
  }

  bool? checkIfbought() {
    return accountRepository.currentAccount?.storeBooksIdList
        .contains(storeBook.id);
  }

  void getCover(String imgLink) async {
    try {
      final gsReference = FirebaseStorage.instance
          .refFromURL("gs://dreamreader-aa940.appspot.com/bookCovers/$imgLink");

      final appDocDir =
          '/data/user/0/com.example.flutter_application_1/app_flutter/$imgLink';
      //final filePath = "${appDocDir.path}/DreamReaderCovers/$imgLink";
      if (File(appDocDir).existsSync()) {
        File file = File(appDocDir);
        final newScreenState = state.copyWith(coverFile: file);
        emit(newScreenState);
        return;
      }
      final file = await File(appDocDir).create();

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
