import 'package:dating_made_better/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heading(context) => GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: TextScaleHelper.scaleText(context, 30),
        fontWeight: FontWeight.w900,
      );

  static TextStyle secondaryHeading(context, {size = 22.0}) =>
      GoogleFonts.poppins(
        color: AppColors.backgroundColor,
        fontSize: TextScaleHelper.scaleText(context, size),
        fontWeight: FontWeight.w700,
      );

  static TextStyle descriptionText(context) => GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: TextScaleHelper.scaleText(context, 11),
        fontWeight: FontWeight.w400,
      );

  static TextStyle regularText(context) => GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: TextScaleHelper.scaleText(context, 16),
        fontWeight: FontWeight.w600,
      );

  static TextStyle dropdownText(context) => GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: TextScaleHelper.scaleText(context, 11),
        fontWeight: FontWeight.w700,
      );

  static TextStyle chatNameText(context) => GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: TextScaleHelper.scaleText(context, 20),
        fontWeight: FontWeight.w700,
      );
}

class TextScaleHelper {
  static double scaleText(BuildContext context, double size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375.0;
    return size * (screenWidth / baseWidth);
  }
}
