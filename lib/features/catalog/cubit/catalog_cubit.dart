import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/store_book.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit({
    required this.storeBookRepository,
    required this.libraryBookRepository,
    required this.accountRepository,
  }) : super(const CatalogState());

  final StoreBookRepository storeBookRepository;
  final LibraryBookRepository libraryBookRepository;
  final AccountRepository accountRepository;

  void initialise() async {
    final newScreenState;
    if (storeBookRepository.storeBookList.isEmpty) {
      newScreenState = state.copyWith(
        storeBooks: await storeBookRepository.getAll(),
        isLoading: false,
      );
    } else {
      newScreenState = state.copyWith(
        storeBooks: storeBookRepository.storeBookList,
        isLoading: false,
      );
    }
    emit(newScreenState);
  }
}
