import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';

class ScreenHeadingWidget extends StatelessWidget {
  const ScreenHeadingWidget(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    bool keyboardHidden = MediaQuery.of(context).viewInsets.bottom == 0;
    return Container(
      margin: EdgeInsets.only(
        top:
            MediaQuery.of(context).size.height / ((keyboardHidden ? 1 : 2) * 8),
        bottom: MediaQuery.of(context).size.height /
            ((keyboardHidden ? 1 : 2) * 16),
        left: marginWidth8(context),
        right: marginWidth8(context),
      ),
      padding: EdgeInsets.symmetric(
        vertical: marginHeight32(context),
        horizontal: marginWidth32(context),
      ),
      color: Colors.transparent,
      child: Text(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: marginHeight32(context),
          fontWeight: FontWeight.w600,
          color: const Color.fromRGBO(255, 205, 234, 1),
        ),
        text,
      ),
    );
  }
}
