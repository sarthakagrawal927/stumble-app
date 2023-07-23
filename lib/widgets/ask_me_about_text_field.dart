import 'package:flutter/material.dart';

import '../constants.dart';

class AskMeAboutTextField extends StatelessWidget {
  const AskMeAboutTextField(this._conversationStarterFocusNode, this.ctx,
      {super.key});
  final FocusNode _conversationStarterFocusNode;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Few things you should come talk to me about!',
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
            initialValue: '',
            maxLines: 3,
            minLines: 1,
            keyboardAppearance: Brightness.dark,
            textInputAction: TextInputAction.next,
            cursorColor: whiteColor,

            onFieldSubmitted: (_) => {
              FocusScope.of(ctx).requestFocus(_conversationStarterFocusNode)
            },
            // Todo: onSaved and validations
          ),
        ),
      ],
    );
  }
}
