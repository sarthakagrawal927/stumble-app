import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';
import '../../screens/swiping_screen.dart';
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
        const ScreenHeadingWidget(
            "Tell people somethings that you're interested in!"),
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(35, 16, 51, 1),
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 16,
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
          () async {
            handleSnackBarIfInputNotFilled(promptTextValue != "", () async {
              Provider.of<Profile>(context, listen: false)
                  .setConversationStarter = promptTextValue;
              if (isLoading) return;
              isLoading = true;
              Provider.of<Profile>(context, listen: false)
                  .upsertUserOnboarding()
                  .then((value) {
                isLoading = false;
                Navigator.of(context).pushNamed(SwipingScreen.routeName);
              });
            }, context, valueToFill: "prompt");
          },
        ),
      ],
    );
  }
}
