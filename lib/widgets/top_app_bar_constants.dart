import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

enum Screen {
  swipingScreen,
  userProfileOverviewScreen,
}

  Icon dropdownMenuIcon(BuildContext context) {
    return Icon(
                      Icons.menu,
                      color: AppColors.primaryColor,
                      size: fontSize32(context),

                    );
  }

  Text headingWidget(BuildContext context, String heading) {
    return Text(
          textAlign: TextAlign.center,
          heading,
          style: AppTextStyles.heading(context),
        );
  }

Container dropDownButtonWithoutPadding(BuildContext context, GlobalKey dropDownKey, Screen screen) {
    return Container(
                  padding: EdgeInsets.only(right: marginWidth32(context)),
                  child: screen == Screen.swipingScreen 
                  ? Showcase(
                      description: "You can find your stumbler lists here!",
                      key: dropDownKey,
                      blurValue: 5,
                      descriptionPadding:
                          EdgeInsets.all(marginWidth128(context)),
                      overlayOpacity: 0.1,
                      showArrow: true,
                      targetPadding:
                          EdgeInsets.all(marginWidth128(context)),
                      child: Transform.scale(
                        scale: 1.25,
                        child: dropdownMenuIcon(context)
                      ))
                  : Transform.scale(
                        scale: 1.25,
                        child: dropdownMenuIcon(context)
                      )
                );
  }

  Showcase swipingScreenHeadingWithShowcase(
    BuildContext context, 
    GlobalKey locationUsageKey,
    String heading) {
    return Showcase(
            description: promptExplainingLocationUsage,
            descTextStyle: TextStyle(fontSize: marginWidth24(context)),
            key: locationUsageKey,
            blurValue: 5,
            descriptionPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 128,
              horizontal: marginWidth128(context),
            ),
            tooltipPosition: TooltipPosition.bottom,
            overlayOpacity: 0.5,
            showArrow: false,
            targetPadding: EdgeInsets.all(marginWidth32(context)),
            child: headingWidget(context, heading)
          );
  }