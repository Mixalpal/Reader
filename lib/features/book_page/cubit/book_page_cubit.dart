import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/account.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_application_1/data/store_book.dart';
import 'package:flutter_application_1/data/review.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_application_1/repository/reviewRepos.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

part 'book_page_state.dart';

class BookPageCubit extends Cubit<BookPageState> {
  BookPageCubit({
    required this.accountRepository,
    required this.libraryBookRepository,
    required this.storeBookRepository,
    required this.reviewRepository,
    required this.storeBook,
  }) : super(BookPageInitial());

  final AccountRepository accountRepository;
  final StoreBookRepository storeBookRepository;
  final LibraryBookRepository libraryBookRepository;
  final ReviewRepository reviewRepository;
  final StoreBook storeBook;

  void initialize() async {
    StoreBook storeBookInitialized = storeBook.copyWith(
      bought: checkIfbought(),
    );
    BookPageState newScreenState;
    if (storeBookInitialized.reviewsIdList.isNotEmpty) {
      List<Review> reviews = [];
      reviews = await reviewRepository
          .getReviewsList(storeBookInitialized.reviewsIdList);
      newScreenState = state.copyWith(
        storeBook: storeBookInitialized,
        reviews: reviews,
      );
      emit(newScreenState);
    } else {
      newScreenState = state.copyWith(storeBook: storeBookInitialized);
    }
    emit(newScreenState);
    getCover(storeBookInitialized.imgLink!);
  }

  bool? checkIfbought() {
    return accountRepository.currentAccount?.storeBooksIdList
        .contains(storeBook.id);
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

  void setRating(int rating) {
    final newScreenState = state.copyWith(
      rating: rating,
    );
    emit(newScreenState);
  }

  void onReviewChanged(String reviewText) {
    final newScreenState = state.copyWith(
      reviewText: reviewText,
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    Account account = await accountRepository.getCurrentAccount();
    Review review = Review(
        score: state.rating,
        comments: [],
        text: state.reviewText,
        authorId: account.username,
        likes: 0,
        bookId: state.storeBook!.id!);
    state.reviews.add(review);
    int score = 0;
    state.reviews.forEach((element) {
      score += element.score;
    });
    state.storeBook!.reviewsIdList.add(reviewRepository.createReview(review));
    StoreBook newStoreBook = state.storeBook!.copyWith(
        avgScore:
            roundDouble(score / (state.storeBook!.reviewsIdList.length), 2));
    final newScreenState = state.copyWith(
      storeBook: newStoreBook,
      reviews: state.reviews,
    );
    emit(newScreenState);
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
        final newScreenState = state.copyWith(
          coverFile: file,
          status: Status.loaded,
        );
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
            final newScreenState = state.copyWith(
              coverFile: file,
              status: Status.loaded,
            );
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
      print('exception in imgLoading fuction: $e');
    }
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places) as double;
    return ((value * mod).round().toDouble() / mod);
  }
}
