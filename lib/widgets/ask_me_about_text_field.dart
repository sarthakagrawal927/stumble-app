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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'What fascinates or interests or you?',
          textAlign: TextAlign.start,
          style: TextStyle(
            backgroundColor: widgetColor,
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 48,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 128,
        ),
        SingleChildScrollView(
          child: TextFormField(
            style: TextStyle(
              color: textColor,
              fontSize: MediaQuery.of(context).size.height / 64,
              backgroundColor: widgetColor,
            ),
            initialValue: currentValue,
            maxLines: 3,
            minLines: 1,
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
