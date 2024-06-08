import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double fontSize16(BuildContext context) {
  return MediaQuery.of(context).size.height / 16;
}

double fontSize24(BuildContext context) {
  return MediaQuery.of(context).size.height / 24;
}

double fontSize28(BuildContext context) {
  return MediaQuery.of(context).size.height / 28;
}

double fontSize32(BuildContext context) {
  return MediaQuery.of(context).size.height / 32;
}

double fontSize48(BuildContext context) {
  return MediaQuery.of(context).size.height / 48;
}

double fontSize64(BuildContext context) {
  return MediaQuery.of(context).size.height / 64;
}

double fontSize80(BuildContext context) {
  return MediaQuery.of(context).size.height / 80;
}

double fontSize96(BuildContext context) {
  return MediaQuery.of(context).size.height / 96;
}

TextStyle headingFont(Color color, BuildContext context) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: fontSize24(context),
  );
}
