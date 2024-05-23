import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';
import '../newUser/screen_heading_widget.dart';
import '../newUser/screen_go_to_next_page_row.dart';

// ignore: must_be_immutable
class PromptAdditionColumn extends StatefulWidget {
  Size deviceSize;
  PromptAdditionColumn(this.deviceSize, {super.key});

  @override
  State<PromptAdditionColumn> createState() => _PromptAdditionColumnState();
}

class _PromptAdditionColumnState extends State<PromptAdditionColumn> {
  String promptTextValue = "";
  FocusNode textFieldFocusNode = FocusNode();
  bool isLoading = false;

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ScreenHeadingWidget("What fascinates or interests or you?"),
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(35, 16, 51, 1),
            margin: EdgeInsets.only(
              left: marginWidth16(context),
              right: marginWidth16(context),
            ),
            child: TextFormField(
              style: const TextStyle(
                color: whiteColor,
                fontSize: 20,
              ),
              initialValue: '',
              maxLines: 3,
              minLines: 1,
              focusNode: textFieldFocusNode,
              autofocus: true,
              keyboardAppearance: Brightness.dark,
              textInputAction: TextInputAction.next,
              cursorColor: whiteColor,
              onChanged: (value) {
                setState(() {
                  promptTextValue = value;
                });
              },
            ),
          ),
        ),
        ScreenGoToNextPageRow(
          "This will be shown on your profile!",
          "",
          () {
            handleSnackBarIfInputNotFilled(promptTextValue != "", () async {
              Provider.of<Profile>(context, listen: false)
                  .setConversationStarter = promptTextValue;
              Provider.of<FirstScreenStateProviders>(context, listen: false)
                  .setNextScreenActive();
            }, context, valueToFill: "prompt");
          },
        ),
      ],
    );
  }
}
