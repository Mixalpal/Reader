import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_application_1/features/library/library_book_widget/cubit/library_book_cubit.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LibraryBookPage extends StatelessWidget {
  const LibraryBookPage({Key? key, required this.libraryBook})
      : super(key: key);
  Page page() => MaterialPage(
          child: LibraryBookPage(
        libraryBook: libraryBook,
      )); // TODO: Убрал static и const

  final LibraryBook libraryBook;

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder(
    //     bloc: StoreBookCubit(storeBook),
    //     builder: ((context, state) {
    //       return StoreBookForm();
    //     }));
    return BlocProvider(
        create: (_) => LibraryBookCubit(
              libraryBook: libraryBook,
              storeBookRepository:
                  RepositoryProvider.of<StoreBookRepository>(context),
              libraryBookRepository:
                  RepositoryProvider.of<LibraryBookRepository>(context),
              accountRepository:
                  RepositoryProvider.of<AccountRepository>(context),
            )..initialize(),
        child: LibraryBookForm(
          libraryBook: libraryBook,
        ));
  }
}

class LibraryBookForm extends StatelessWidget {
  const LibraryBookForm({Key? key, required this.libraryBook})
      : super(key: key);

  final LibraryBook libraryBook;

  static const TextStyle mainTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle secondaryTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle scoreTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryBookCubit, LibraryBookState>(
        listenWhen: (oldState, newState) =>
            oldState.libraryBook != newState.libraryBook,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = context.read<LibraryBookCubit>();
          cubit.initialize();
          return Container(
            height: 150,
            margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Color.fromRGBO(204, 204, 204, 1),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => {
                    // TODO: open book page
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //eto kartinka
                      Expanded(
                        flex: 115,
                        child: state.coverFile == null
                            ? Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Color.fromRGBO(50, 50, 50, 1),
                                ))
                            : Image.file(state.coverFile!),
                      ),
                      Expanded(
                        flex: 227,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 12,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    libraryBook.name.toString(),
                                    textAlign: TextAlign.left,
                                    style: mainTextStyle,
                                  ),
                                )),
                            Expanded(
                                flex: 16,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    libraryBook.author,
                                    textAlign: TextAlign.left,
                                    style: secondaryTextStyle,
                                  ),
                                )),
                            Expanded(
                              flex: 10,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 1, 7, 7),
                                  child: GestureDetector(
                                    onTap: () => {
                                      context.goNamed('reader',
                                          extra: state.libraryBook)
                                    },
                                    child: Container(
                                        color: const Color.fromRGBO(
                                            236, 143, 0, 1),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Читать",
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
