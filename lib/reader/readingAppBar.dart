import 'package:flutter/material.dart';

class ReadingAppBar extends StatefulWidget {
  const ReadingAppBar({super.key, required bool visibility});

  @override
  State<ReadingAppBar> createState() => _ReadingAppBar();
}

class _ReadingAppBar extends State<ReadingAppBar> {
  bool kakJeEtoNazvat = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(//GestureDetectors

              ),
          Container(//Text

              ),
        ],
      ),
    );
  }
}
