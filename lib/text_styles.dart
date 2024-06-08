import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle Heading(context) => GoogleFonts.poppins(
      color: Color.fromRGBO(15, 42, 70, 1),
      fontSize: TextScaleHelper.scaleText(context, 30),
      fontWeight: FontWeight.w900,
    );

}

class TextScaleHelper {
  static double scaleText(BuildContext context, double size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375.0; 
    return size * (screenWidth / baseWidth);
  }
}