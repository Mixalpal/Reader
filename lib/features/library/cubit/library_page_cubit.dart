import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_application_1/data/account.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';

part 'library_page_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit({
    required this.libraryBookRepository,
    required this.accountRepository,
  }) : super(const LibraryState());

  final LibraryBookRepository libraryBookRepository;
  final AccountRepository accountRepository;

  void initialise() async {
    final newScreenState;
    Account account = await accountRepository.getCurrentAccount();
    // List<String> libraryBookIds =
    //     await accountRepository.currentAccount!.booksIdList;
    newScreenState = state.copyWith(
      libraryBooks:
          await libraryBookRepository.getUserLibraryBooks(account.booksIdList),
      isLoading: false,
    );
    emit(newScreenState);
  }
}
