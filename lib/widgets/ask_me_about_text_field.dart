import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/profile.dart';

class AskMeAboutTextField extends StatelessWidget {
  const AskMeAboutTextField(
      this._conversationStarterFocusNode, this.ctx, this.currentValue,
      {super.key});
  final FocusNode _conversationStarterFocusNode;
  final BuildContext ctx;
  final String currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'What fascinates or interests or you?',
          textAlign: TextAlign.start,
          style: TextStyle(
            backgroundColor: widgetColor,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          child: TextFormField(
            style: const TextStyle(
              color: whiteColor,
              fontSize: 20,
              backgroundColor: widgetColor,
            ),
            initialValue: currentValue,
            maxLines: 3,
            minLines: 1,
            keyboardAppearance: Brightness.dark,
            textInputAction: TextInputAction.next,
            cursorColor: whiteColor,
            onChanged: (newValue) => {
              Provider.of<Profile>(context, listen: false)
                  .setConversationStarter = newValue,
            },
            onEditingComplete: () =>
                FocusScope.of(ctx).requestFocus(_conversationStarterFocusNode),
            // Todo: onSaved and validations
          ),
        ),
      ],
    );
  }
}
