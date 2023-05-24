import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/catalog/cubit/catalog_cubit.dart';
import 'package:flutter_application_1/features/catalog/store_book_widget/store_book_page.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: CatalogPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatalogCubit(
        libraryBookRepository:
            RepositoryProvider.of<LibraryBookRepository>(context),
        storeBookRepository:
            RepositoryProvider.of<StoreBookRepository>(context),
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
      )..initialise(),
      child: BlocConsumer<CatalogCubit, CatalogState>(
        listenWhen: (oldState, newState) =>
            oldState.storeBooks != newState.storeBooks,
        listener: (context, state) {
          if (state.isLoading == true) {
            final cubit = context.read<CatalogCubit>();
            cubit.initialise();
          }
        },
        builder: (context, state) {
          final cubit = context.read<CatalogCubit>();
          cubit.initialise();
          if (state.storeBooks.isEmpty) {
            return Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => {cubit.initialise()},
                  child: Column(
                    children: [
                      Expanded(flex: 6, child: Container()),
                      Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text('Ошибка загрузки')),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => {cubit.initialise()},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(236, 143, 0, 1),
                            ),
                            alignment: Alignment.topCenter,
                            height: 45,
                            width: 150,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Обновить',
                                style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 6, child: Container())
                    ],
                  ),
                ));
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (var book in state.storeBooks)
                  StoreBookPage(storeBook: book)
              ],
            );
          }
        },
      ),
    );
  }
}


// class SignInPage extends StatelessWidget {
//   const SignInPage({Key? key}) : super(key: key);
//   static Page page() => const MaterialPage<void>(child: SignInPage());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: BlocProvider(
//       create: (_) => SignInCubit(
//         accountRepository: RepositoryProvider.of<AccountRepository>(context),
//       ),
//       child: const SignInForm(),
//     ));
//   }
// }