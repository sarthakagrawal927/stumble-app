import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/common/dialog_widget.dart';
import 'package:flutter/material.dart';

Future<dynamic> reportUserWidget({
  required BuildContext context,
  required Future<Null> Function() onReport,
  required String profileName,
  required int profileId,
  required int source,
}) {
  String reportMessage = "";

  return dialogWidget(
    context: context,
    title: 'Report $profileName',
    submitLabel: 'Report',
    onSubmit: () async {
      reportAndBlockUserApi(profileId, reportSourceProfile, reportMessage)
          .then((value) => {
                onReport(),
              });
    },
    childWidget: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'We encourage you to drop a message if you\'re reporting a user, so we can assist you promptly.',
          style: AppTextStyles.descriptionText(context),
        ),
        SizedBox(height: marginHeight16(context)),
        TextField(
          maxLines: 2,
          minLines: 1,
          cursorColor: Colors.black,
          autocorrect: true,
          decoration: InputDecoration(
            hintText: 'Your reason for report',
            hintStyle: AppTextStyles.descriptionText(context),
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          style: AppTextStyles.descriptionText(context),
          autofocus: true,
          maxLength: 25,
          onChanged: (value) {
            reportMessage = value;
          },
        ),
        Text(
          'This will block the user from contacting you and remove them from your matches.',
          style: AppTextStyles.descriptionText(context),
        ),
      ],
    ),
  );
}
