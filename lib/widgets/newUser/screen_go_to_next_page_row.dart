import 'package:flutter/material.dart';

import '../../constants.dart';

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
              size: marginWidth16(context),
              color: whiteColor,
            ),
            Text(
              textToDisplay,
              style: const TextStyle(fontSize: 15, color: whiteColor),
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
                color: whiteColor,
                size: marginWidth16(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
