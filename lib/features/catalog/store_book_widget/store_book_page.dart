import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/store_book.dart';
import 'package:flutter_application_1/features/catalog/store_book_widget/cubit/store_book_cubit.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class StoreBookPage extends StatelessWidget {
  const StoreBookPage({Key? key, required this.storeBook}) : super(key: key);
  Page page() => MaterialPage(
          child: StoreBookPage(
        storeBook: storeBook,
      )); // TODO: Убрал static и const

  final StoreBook storeBook;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => StoreBookCubit(
              storeBook: storeBook,
              storeBookRepository:
                  RepositoryProvider.of<StoreBookRepository>(context),
              libraryBookRepository:
                  RepositoryProvider.of<LibraryBookRepository>(context),
              accountRepository:
                  RepositoryProvider.of<AccountRepository>(context),
            )..initialize(),
        child: StoreBookForm(
          storeBook: storeBook,
        ));
  }
}

class StoreBookForm extends StatelessWidget {
  const StoreBookForm({Key? key, required this.storeBook}) : super(key: key);

  final StoreBook storeBook;

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
    return BlocConsumer<StoreBookCubit, StoreBookState>(
        listenWhen: (oldState, newState) =>
            oldState.storeBook != newState.storeBook,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = context.read<StoreBookCubit>();
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
                  onTap: () =>
                      {context.goNamed('bookPage', extra: state.storeBook)},
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
                      ), // TODO: Обложка
                      Expanded(
                        flex: 227,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 12,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    storeBook.name.toString(),
                                    textAlign: TextAlign.left,
                                    style: mainTextStyle,
                                  ),
                                )),
                            Expanded(
                                flex: 6,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    storeBook.author,
                                    textAlign: TextAlign.left,
                                    style: secondaryTextStyle,
                                  ),
                                )),
                            Expanded(
                              flex: 10,
                              child: Align(
                                alignment: Alignment.topLeft,
                                // TODO: Сюдя функцию красящую оценку и нормально поставить ее
                                child: Text(
                                  storeBook.avgScore.toString(),
                                  textAlign: TextAlign.left,
                                  style: scoreTextStyle,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: state.storeBook.bought == false
                                  ? BuyButton(cubit)
                                  : Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 1, 7, 7),
                                      child: Container(
                                          color: const Color.fromRGBO(
                                              255, 170, 40, 1),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Куплено",
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
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

  Widget BuyButton(StoreBookCubit cubit) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 1, 7, 7),
        child: GestureDetector(
          onTap: () => {
            cubit.buy(storeBook),
          },
          child: Container(
              color: const Color.fromRGBO(236, 143, 0, 1),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Купить ${storeBook.price}₽",
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
    );
  }
}
