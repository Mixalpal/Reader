import 'package:flutter/material.dart';

class BookWidget extends StatefulWidget {
  const BookWidget({super.key});

  @override
  State<BookWidget> createState() => _BookWidget();
}

class _BookWidget extends State<BookWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(204, 204, 204, 1),
          ),
          borderRadius: BorderRadius.circular(10),
          //color: Color.fromRGBO(204, 204, 204, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[Text("Верхний текст")],
            ),
            Row(
              children: <Widget>[
                Text("Нижний текст"),
              ],
            ),
          ],
        ));
  }
}
