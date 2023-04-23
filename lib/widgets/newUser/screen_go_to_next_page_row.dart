import 'package:flutter/material.dart';

class ScreenGoToNextPageRow extends StatelessWidget {
  const ScreenGoToNextPageRow(
      this.textToDisplay, this.nextScreenRouteName, this.functionToSetData,
      {super.key});
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
              color: const Color.fromRGBO(15, 15, 15, 1),
            ),
            Text(
              textToDisplay,
              style: const TextStyle(
                  fontSize: 15, color: Color.fromRGBO(237, 237, 237, 1)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              onPressed: (() async {
                await functionToSetData();
                if (context.mounted && nextScreenRouteName != "") {
                  Navigator.pushReplacementNamed(context, nextScreenRouteName);
                }
              }),
              child: Icon(
                Icons.arrow_forward,
                color: const Color.fromRGBO(15, 15, 15, 1),
                size: MediaQuery.of(context).size.width / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
