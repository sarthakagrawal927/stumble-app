import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/common/dialog_widget.dart';
import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
import 'package:flutter/material.dart';

Future<dynamic> userFeedbackWidget({required BuildContext context}) {
  final userFeedbackController = TextEditingController();
  final userPhoneNumberController = TextEditingController(text: '+91');

  return dialogWidget(
    context: context,
    title: 'Leave a feedback!',
    submitLabel: 'Submit',
    onSubmit: () async {
      if (userFeedbackController.text.isEmpty) {
        showSnackBar(context, "Feedback cannot be empty!");
      } else {
        sendFeedbackApi(
                userPhoneNumberController.text, userFeedbackController.text)
            .then(
                (value) => Navigator.of(context, rootNavigator: true).pop(""));
      }
    },
    childWidget: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'We\'d love to hear YOU, to make stumbling a better experience for YOU!',
          style: AppTextStyles.descriptionText(context),
        ),
        SizedBox(height: marginHeight48(context)),
        TextField(
          maxLines: 6,
          minLines: 1,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'Enter your feedback here...',
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            hintStyle: AppTextStyles.descriptionText(context),
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          style: AppTextStyles.descriptionText(context),
          autofocus: true,
          cursorErrorColor: AppColors.primaryColor,
          controller: userFeedbackController,
        ),
        SizedBox(height: marginHeight48(context)),
        TextField(
          maxLines: 2,
          minLines: 1,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: AppTextStyles.descriptionText(context),
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          style: AppTextStyles.descriptionText(context),
          controller: userPhoneNumberController,
        ),
      ],
    ),
  );
}
