import 'package:flutter/material.dart';

class ScreenHeadingWidget extends StatelessWidget {
  const ScreenHeadingWidget(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    bool keyboardHidden = MediaQuery.of(context).viewInsets.bottom == 0;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical:
            MediaQuery.of(context).size.height / ((keyboardHidden ? 1 : 2) * 8),
        horizontal: MediaQuery.of(context).size.width / 8,
      ),
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 32,
        horizontal: MediaQuery.of(context).size.width / 32,
      ),
      color: Colors.black38,
      child: Text(
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        text,
      ),
    );
  }
}
