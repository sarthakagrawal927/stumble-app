import 'package:flutter/material.dart';

class ButtonToAcceptOrRejectConditions extends StatelessWidget {
  ButtonToAcceptOrRejectConditions(
      this.textToDisplay, this.colorOfButton, this.nextScreenRouteName);
  final String textToDisplay;
  final Color colorOfButton;
  final String nextScreenRouteName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(26, 28, 29, 0),
            fixedSize: Size(
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 16,
            ),
          ),
          onPressed: (() {
            Navigator.of(context).pushReplacementNamed(nextScreenRouteName);
          }),
          child: Text(
            textToDisplay,
            style: TextStyle(
              fontSize: 30,
              color: colorOfButton,
            ),
          ),
        ),
      ),
    );
  }
}
