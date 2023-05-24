import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_application_1/data/store_book.dart';
import 'package:flutter_application_1/features/book_page/book_page.dart';
import 'package:flutter_application_1/features/sign_in/sign_in_page.dart';
import 'package:flutter_application_1/features/sign_up/sign_up_page.dart';
import 'package:flutter_application_1/reader/reader_page.dart';
import 'package:flutter_application_1/repository/accountRepos.dart';
import 'package:flutter_application_1/repository/reviewRepos.dart';
import 'package:flutter_application_1/repository/storeBookRepos.dart';
import 'package:flutter_application_1/repository/libraryBookRepos.dart';
import 'features/navBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/features/settings/settings.dart'
    as settingsWidget;

part 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AccountRepository()),
        RepositoryProvider(create: (_) => StoreBookRepository()),
        RepositoryProvider(create: (_) => LibraryBookRepository()),
        RepositoryProvider(create: (_) => ReviewRepository()),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Dream Reader',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(255, 185, 78, 1),
          unselectedWidgetColor: Color.fromRGBO(204, 204, 204, 1),
        ),
      ),
    );
  }
}
