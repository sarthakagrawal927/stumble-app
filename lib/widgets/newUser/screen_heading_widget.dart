import 'package:flutter/material.dart';

class ScreenHeadingWidget extends StatelessWidget {
  const ScreenHeadingWidget(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 8,
        horizontal: MediaQuery.of(context).size.width / 16,
      ),
      child: Text(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.black54,
            backgroundColor: Color.fromRGBO(230, 230, 250, 0.5),
          ),
          text),
    );
  }
}
