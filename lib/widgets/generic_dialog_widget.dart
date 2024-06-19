import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

enum PromptReason {
  deletionPrompt,
  appFeedback,
  reportUser,
}

Map<PromptReason, String> promptDisplayText = {
  PromptReason.deletionPrompt:
      "It saddens us to witness your stumbling come to a halt in discovering more incredible individuals!",
  PromptReason.appFeedback:
      "We'd love to hear YOU, to make stumbling a better experience for YOU!",
  PromptReason.reportUser:
      "We encourage you to drop a message if you're reporting a user, so we can assist you promptly."
};

Future<dynamic> genericDialogWidget(BuildContext context,
    {PromptReason reason = PromptReason.appFeedback,
    Map<String, dynamic> extraParams = const {}}) {
  String phoneNumber = "";
  String feedback = "";
  TextEditingController controller = TextEditingController();

  return showDialog(
    context: context,
    barrierColor: Colors.transparent.withOpacity(0.5),
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: marginWidth32(context),
                vertical: marginHeight128(context),
              ),
              child: Text(
                style: AppTextStyles.regularText(context),
                textAlign: TextAlign.left,
                softWrap: true,
                promptDisplayText[reason]!,
              ),
            ),
            reason == PromptReason.deletionPrompt
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: marginWidth32(context),
                      vertical: marginHeight128(context),
                    ),
                    child: Text(
                      style: AppTextStyles.regularText(context, size: 10.0),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      "Sure about leaving your stumblers? :(",
                    ))
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: marginWidth32(context),
                      vertical: marginHeight128(context),
                    ),
                    child: TextField(
                      maxLines: 2,
                      minLines: 1,
                      cursorColor: Colors.black,
                      autocorrect: true,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      style: AppTextStyles.descriptionText(context),
                      maxLength: 25,
                      onChanged: (value) {
                        feedback = value;
                      },
                    ),
                  ),
            reason == PromptReason.appFeedback
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: marginWidth32(context),
                      vertical: marginHeight128(context),
                    ),
                    child: InternationalPhoneNumberInput(
                      cursorColor: headingColor,
                      onInputChanged: (PhoneNumber number) {
                        phoneNumber = number.phoneNumber!;
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      selectorTextStyle: const TextStyle(color: headingColor),
                      autoFocus: true,
                      hintText: "Phone number",
                      keyboardAction: TextInputAction.done,
                      textFieldController: controller,
                      textStyle: const TextStyle(color: headingColor),
                      formatInput: true,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: const OutlineInputBorder(),
                      onFieldSubmitted: (value) {
                        phoneNumber = value;
                      },
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: marginWidth32(context),
                vertical: marginHeight128(context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.black,
                        size: marginWidth12(context),
                      ),
                      onPressed: () async {
                        reason == PromptReason.appFeedback
                            ? {
                                sendFeedbackApi(phoneNumber, feedback),
                                Navigator.of(context, rootNavigator: true)
                                    .pop("")
                              }
                            : reason == PromptReason.reportUser
                                ? {
                                    reportAndBlockUserApi(
                                        extraParams[badActorIdKey],
                                        extraParams[reportSourceKey],
                                        feedback),
                                    if (extraParams[reportSourceKey] ==
                                        reportSourceChat)
                                      {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushReplacementNamed(
                                                MatchesAndChatsScreen.routeName)
                                      }
                                    else
                                      {
                                        // refresh the page
                                        Navigator.pushReplacementNamed(
                                            context, SwipingScreen.routeName)
                                      }
                                  }
                                : {
                                    await deleteUserApi(),
                                    AppConstants.token = "",
                                    AppConstants.user = {},
                                    deleteSecureData(authKey).then((value) => {
                                          Provider.of<FirstScreenStateProviders>(
                                                  context,
                                                  listen: false)
                                              .setActiveScreenMode(
                                                  ScreenMode.landing),
                                          Navigator.pushNamed(
                                              context, AuthScreen.routeName)
                                        })
                                  };
                      }),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: marginWidth12(context),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop("");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
