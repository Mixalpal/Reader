import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:fb2_parse/fb2_parse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/library_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_application_1/reader/cubit/reader_cubit.dart';

class Reader_Page extends StatelessWidget {
  const Reader_Page({super.key, required this.libraryBook});
  final LibraryBook libraryBook;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(libraryBook: libraryBook)..initialize(),
      child: ReaderView(
        libraryBook: libraryBook,
      ),
    );
  }
}

class ReaderView extends StatelessWidget {
  const ReaderView({Key? key, required this.libraryBook}) : super(key: key);
  final LibraryBook libraryBook;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReaderCubit, ReaderState>(
      listenWhen: (oldState, newState) =>
          oldState.status != newState.status ||
          oldState.bookName != newState.bookName,
      listener: (context, state) {
        if (state.status == Status.loading) {
          // final cubit = context.read<ReaderCubit>();
          // cubit.initialize();
        }
      },
      builder: (context, state) {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [],
        );

        final cubit = context.read<ReaderCubit>();
        return state.status == Status.loaded
            ? Scaffold(
                body: Stack(children: [
                SizedBox.expand(
                  /// the content of the fb2 file is html
                  child: GestureDetector(
                      onTap: () => {},
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        debuggingEnabled: true,
                        zoomEnabled: false,
                        onWebViewCreated:
                            (WebViewController webViewController) async {
                          final WebViewController controller =
                              webViewController;

                          /// load data. You can add design tags
                          await controller.loadUrl(Uri.dataFromString('''
                                  <style>
                                  body{
                                    background-color: ${state.nightModeOn == true ? 'black' : 'white'}; 
                                  } 
                                  p {
                                    background-color: ${state.nightModeOn == true ? 'black' : 'white'}; 
                                    color: ${state.nightModeOn == true ? 'white' : 'black'}; 
                                    font-family: '${state.settings!.font}';
                                    font-size: ${state.settings!.fontSize + 20};
                                  }
                                  </style>
                                    <body>
                                      ${state.book!.body.sections![state.currentPage - 1].content}
                                    <body/>
                                    ''',
                                  mimeType: 'text/html',
                                  encoding: Encoding.getByName('utf-8'))
                              .toString());
                        },
                      )),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      onTap: () => {cubit.goBack()},
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      onTap: () => {cubit.menuClick()},
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      onTap: () => {cubit.goForward()},
                    ),
                  ],
                ),
                ReadingAppBar(
                  cubit: cubit,
                  state: state,
                ),
              ]))
            : Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              );
      },
    );
  }
}

class ReadingAppBar extends StatelessWidget {
  ReadingAppBar({
    required this.cubit,
    required this.state,
  });

  ReaderCubit cubit;
  ReaderState state;

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //top bar
        Expanded(
          flex: 1,
          child: Container(color: Colors.orange),
        ),
        //center
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: () => cubit.menuClick(),
            child: SizedBox.expand(),
          ),
        ),
        //bottom bar
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.orange,
            )),
      ],
    );
  }
}
