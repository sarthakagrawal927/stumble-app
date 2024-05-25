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
            Padding(
              padding: EdgeInsets.only(
                left: marginWidth128(context), 
                top: marginHeight128(context), 
                bottom: marginHeight32(context),
              ),
              child: Icon(
                Icons.remove_red_eye,
                size: marginWidth16(context),
                color: whiteColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: marginWidth128(context), 
                top: marginHeight128(context), 
                bottom: marginHeight32(context),
                ),
              child: Text(
                textToDisplay,
                style:  TextStyle(fontSize: marginWidth32(context), 
                color: whiteColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: marginWidth128(context), 
                right: marginWidth128(context),
                top: marginHeight128(context), 
                bottom: marginHeight32(context),
                ),  
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
