import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<Object?> promptDialog(BuildContext context, String text) {
  return showGeneralDialog(
    barrierColor: topAppBarColor,
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => Center(
      child: Container(
        color: widgetColor,
        margin: EdgeInsets.symmetric(
          vertical: marginHeight8(context),
          horizontal: marginWidth8(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: GoogleFonts.acme(
              color: headingColor,
              fontSize: 30,
            ),
            child: Text(
              textAlign: TextAlign.center,
              text,
            ),
          ),
        ),
      ),
    ),
  );
}
