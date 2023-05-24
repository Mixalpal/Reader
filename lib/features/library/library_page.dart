import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/library/cubit/library_page_cubit.dart';
import 'package:flutter_application_1/features/library/library_book_widget/library_book_page.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: LibraryPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LibraryCubit(
        libraryBookRepository:
            RepositoryProvider.of<LibraryBookRepository>(context),
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
      )..initialise(),
      child: BlocConsumer<LibraryCubit, LibraryState>(
        listenWhen: (oldState, newState) =>
            oldState.libraryBooks != newState.libraryBooks,
        listener: (context, state) {
          if (state.isLoading == true) {
            // final cubit = context.read<LibraryCubit>();
            // cubit.initialise();
          }
        },
        builder: (context, state) {
          final cubit = context.read<LibraryCubit>();
          //cubit.initialise();
          if (state.isLoading == true) {
            return Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => {cubit.initialise()},
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(),
                      ),
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
                      Expanded(
                        flex: 6,
                        child: Container(),
                      ),
                    ],
                  ),
                ));
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (var book in state.libraryBooks)
                  LibraryBookPage(
                    libraryBook: book,
                  ),
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