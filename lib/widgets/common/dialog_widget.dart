import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/widgets/common/buttons.dart';
import 'package:flutter/material.dart';

Future<dynamic> dialogWidget({
  required BuildContext context,
  required String submitLabel,
  required Future<Null> Function() onSubmit,
  required String title,
  Widget? childWidget,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text in center
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadiusValue),
                  topRight: Radius.circular(borderRadiusValue),
                ),
              ),
              child: Text(
                title,
                style: AppTextStyles.secondaryHeading(context),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.backgroundColor,
              child: Column(children: [
                childWidget!,
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SecondaryButton(
                        text: "Close",
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop("");
                        }),
                    const SizedBox(width: 12),
                    SecondaryButton(text: submitLabel, onPressed: onSubmit),
                  ],
                ),
              ]),
            )
          ],
        ),
      );
    },
  );
}
