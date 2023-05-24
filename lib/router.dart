part of 'main.dart';

final _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => SignInPage()),
  GoRoute(
    path: '/registration',
    builder: (context, state) => SignUpPage(),
  ),
  GoRoute(path: '/library', builder: (context, state) => NavBar(), routes: [
    GoRoute(
      path: 'reader',
      name: 'reader',
      builder: (context, state) {
        LibraryBook book = state.extra as LibraryBook;
        return Reader_Page(libraryBook: book);
      },
    ),
    GoRoute(
      path: 'bookPage',
      name: 'bookPage',
      builder: (context, state) {
        StoreBook book = state.extra as StoreBook;
        return BookPage(storeBook: book);
      },
    ),
  ]),
  GoRoute(
    path: '/settings',
    builder: (context, state) => settingsWidget.Settings(),
  ),
]);
