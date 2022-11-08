import 'package:flutter/material.dart';

class BookWidget extends StatefulWidget {
  const BookWidget({super.key});

  @override
  State<BookWidget> createState() => _BookWidget();
}

class _BookWidget extends State<BookWidget> {
  void onStarPressed() {}

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
          Row(
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
                            "Название",
                            textAlign: TextAlign.left,
                            style: mainTextStyle,
                          ),
                        )),
                    Expanded(
                        flex: 40,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Автор",
                            textAlign: TextAlign.left,
                            style: secondaryTextStyle,
                          ),
                        )),
                    Expanded(
                      flex: 10,
                      child: Text("ProgressBarздесьбудет"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onStarPressed,
                icon: Icon(Icons.star),
              ))
        ]));
  }
}
