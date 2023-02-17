import 'package:flutter/material.dart';

class ScreenGoToNextPageRow extends StatelessWidget {
  ScreenGoToNextPageRow(
      this.textToDisplay, this.nextScreenRouteName, this.functionToSetData);
  final String textToDisplay;
  final String nextScreenRouteName;
  final Function functionToSetData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.remove_red_eye,
              size: MediaQuery.of(context).size.width / 16,
              color: Color.fromRGBO(116, 91, 53, 1),
            ),
            Text(
              textToDisplay,
              style: const TextStyle(
                  fontSize: 15, color: Color.fromRGBO(237, 237, 237, 1)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(26, 28, 29, 1),
              ),
              onPressed: (() async {
                await functionToSetData();
                Navigator.pushReplacementNamed(context, nextScreenRouteName);
              }),
              child: Icon(
                Icons.arrow_forward,
                color: Color.fromRGBO(116, 91, 53, 1),
                size: MediaQuery.of(context).size.width / 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
