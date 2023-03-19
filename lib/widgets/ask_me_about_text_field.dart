import 'package:flutter/material.dart';

class AskMeAboutTextField extends StatelessWidget {
  const AskMeAboutTextField(this._conversationStarterFocusNode, this.ctx);
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
            color: Color.fromRGBO(237, 237, 237, 1),
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
              color: Color.fromRGBO(237, 237, 237, 1),
              fontSize: 20,
            ),
            initialValue: '',
            maxLines: 3,
            minLines: 1,
            keyboardAppearance: Brightness.dark,
            textInputAction: TextInputAction.next,
            cursorColor: const Color.fromRGBO(237, 237, 237, 1),

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
