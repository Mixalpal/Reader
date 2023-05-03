import 'package:flutter/material.dart';
import 'package:flutter_application_1/books/book.dart';
import 'package:flutter_application_1/reader/reader_page.dart';

class BookWidget extends StatefulWidget {
  final Book book;
  const BookWidget({super.key, required this.book});

  @override
  State<BookWidget> createState() => _BookWidget();
}

class _BookWidget extends State<BookWidget> {
  void onStarPressed() {
    setState(() {
      widget.book.isFavourite = !widget.book.isFavourite;
    });
  }

  final TextStyle mainTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  final TextStyle secondaryTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
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
        child: Stack(children: [
          GestureDetector(
            onTap: () => {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => ReadingWindow(
              //             book: widget.book,
              //           )),
              // )
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 115,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Color.fromRGBO(50, 50, 50, 1),
                    ),
                  ), //Обложка
                ),
                Expanded(
                  flex: 227,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 10,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.book.name,
                              textAlign: TextAlign.left,
                              style: mainTextStyle,
                            ),
                          )),
                      Expanded(
                          flex: 40,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.book.author,
                              textAlign: TextAlign.left,
                              style: secondaryTextStyle,
                            ),
                          )),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                          child: LinearProgressIndicator(
                            backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                            color: Color.fromRGBO(10, 207, 131, 1),
                            value: widget.book.progress,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                color: widget.book.isFavourite
                    ? Color.fromRGBO(236, 143, 0, 1)
                    : Color.fromRGBO(217, 217, 217, 1),
                onPressed: onStarPressed,
                icon: Icon(Icons.star),
              ))
        ]));
  }
}
