import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/store_book.dart';
import 'package:flutter_application_1/data/review.dart';
import 'package:flutter_application_1/features/book_page/cubit/book_page_cubit.dart';
import 'package:flutter_application_1/features/catalog/store_book_widget/cubit/store_book_cubit.dart';
import 'package:flutter_application_1/features/sign_in/sign_in_page.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/reviewRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key, required this.storeBook}) : super(key: key);
  Page page() => MaterialPage<void>(child: BookPage(storeBook: storeBook));

  final StoreBook storeBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (_) => BookPageCubit(
            storeBook: storeBook,
            storeBookRepository:
                RepositoryProvider.of<StoreBookRepository>(context),
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
            libraryBookRepository:
                RepositoryProvider.of<LibraryBookRepository>(context),
            reviewRepository: RepositoryProvider.of<ReviewRepository>(context),
          )..initialize(),
          child: BookPageForm(),
        ));
  }
}

class BookPageForm extends StatelessWidget {
  const BookPageForm({Key? key}) : super(key: key);

  static const TextStyle mainTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle secondaryTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle scoreTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookPageCubit, BookPageState>(
        listenWhen: (oldState, newState) =>
            oldState.storeBook != newState.storeBook ||
            oldState.reviews != newState.reviews ||
            oldState.coverFile != newState.coverFile ||
            oldState.status != newState.status ||
            oldState.rating != newState.rating ||
            oldState.reviewText != newState.reviewText,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: [],
          );
          final cubit = context.read<BookPageCubit>();
          return state.status == Status.loaded
              ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color.fromRGBO(41, 41, 41, 1),
                          width: 3,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(children: [
                        SizedBox(
                          height: 200,
                          child: Container(
                            child: Row(children: [
                              //Image
                              Expanded(
                                flex: 117,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: state.coverFile == null
                                      ? Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color:
                                                Color.fromRGBO(50, 50, 50, 1),
                                          ))
                                      : Image.file(state.coverFile!),
                                ),
                              ),
                              //Info
                              Expanded(
                                flex: 227,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 8,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            state.storeBook!.name.toString(),
                                            textAlign: TextAlign.left,
                                            style: mainTextStyle,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            state.storeBook!.author,
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
                                          state.storeBook!.avgScore.toString(),
                                          textAlign: TextAlign.left,
                                          style: scoreTextStyle,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: state.storeBook!.bought == false
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 1, 7, 7),
                                                child: GestureDetector(
                                                  onTap: () => {
                                                    cubit.buy(state.storeBook!),
                                                  },
                                                  child: Container(
                                                      color:
                                                          const Color.fromRGBO(
                                                              236, 143, 0, 1),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Купить ${state.storeBook!.price}₽",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 1, 7, 7),
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
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                        //Write review
                        Expanded(
                          flex: 20,
                          child: const Text(
                            'Напишите ваш отзыв',
                            style: mainTextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 18,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () => {cubit.setRating(1)},
                                    icon: Icon(Icons.star),
                                    color: state.rating >= 1
                                        ? Color.fromRGBO(79, 121, 66, 1)
                                        : Colors.grey),
                                IconButton(
                                    onPressed: () => {cubit.setRating(2)},
                                    icon: Icon(Icons.star),
                                    color: state.rating >= 2
                                        ? Color.fromRGBO(79, 121, 66, 1)
                                        : Colors.grey),
                                IconButton(
                                    onPressed: () => {cubit.setRating(3)},
                                    icon: Icon(Icons.star),
                                    color: state.rating >= 3
                                        ? Color.fromRGBO(79, 121, 66, 1)
                                        : Colors.grey),
                                IconButton(
                                    onPressed: () => {cubit.setRating(4)},
                                    icon: Icon(Icons.star),
                                    color: state.rating >= 4
                                        ? Color.fromRGBO(79, 121, 66, 1)
                                        : Colors.grey),
                                IconButton(
                                    onPressed: () => {cubit.setRating(5)},
                                    icon: Icon(Icons.star),
                                    color: state.rating >= 5
                                        ? Color.fromRGBO(79, 121, 66, 1)
                                        : Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 70,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(245, 245, 245, 1)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: TextField(
                                  expands: false,
                                  maxLines: 8,
                                  onChanged: (String value) =>
                                      cubit.onReviewChanged(value),
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    fillColor: Color.fromRGBO(153, 153, 153, 1),
                                    hintText: 'Текст отзыва',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(236, 143, 0, 1),
                                  ),
                                  onPressed: () => {cubit.onSubmit()},
                                  child: Text(
                                    'Опубликовать',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ))),
                          //Other reviews
                        ),
                        Expanded(
                          flex: 150,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              for (var review in state.reviews)
                                ReviewForm(review: review, cubit: cubit),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                );
        });
  }
}

class ReviewForm extends StatelessWidget {
  const ReviewForm({Key? key, required this.review, required this.cubit})
      : super(key: key);

  final Review review;
  final BookPageCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromRGBO(41, 41, 41, 1),
            width: 3,
          )),
      child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        review.authorId,
                        style: secondaryTextStyle,
                      )),
                  Expanded(child: Container()),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        review.score.toString(),
                        style: BookPageForm.scoreTextStyle,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(review.text),
                ),
              )
            ],
          )),
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
