import 'package:flutter/material.dart';

// Make it different modes, think of a way to not pass build context
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

String getSingleInputMissingMessage(String missingInput) {
  return "Please enter your $missingInput";
}

/// This function is used to show snackbar if any input is not filled
/// Atleast send one of the two parameters: valueToFill or message
void handleSnackBarIfInputNotFilled(bool valueFilled,
    Future<void> Function() filledValueProcess, BuildContext context,
    {String valueToFill = "", String message = ""}) {
  if (valueFilled) {
    filledValueProcess();
  } else {
    if (message.isEmpty) {
      message = getSingleInputMissingMessage(valueToFill);
    }
    showSnackBar(context, message);
  }
}
