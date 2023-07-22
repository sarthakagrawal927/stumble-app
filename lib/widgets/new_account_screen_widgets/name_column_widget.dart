import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';
import '../newUser/screen_heading_widget.dart';
import '../newUser/screen_go_to_next_page_row.dart';

// ignore: must_be_immutable
class NameColumn extends StatefulWidget {
  Size deviceSize;
  NameColumn(this.deviceSize, {super.key});

  @override
  State<NameColumn> createState() => _NameColumnState();
}

class _NameColumnState extends State<NameColumn> {
  final nameTextBoxController = TextEditingController();
  String _name = "LMAO";

  @override
  void dispose() {
    nameTextBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("What's your first name?"),
        Container(
          margin: EdgeInsets.only(
            left: widget.deviceSize.width / 16,
            right: widget.deviceSize.width / 16,
          ),
          padding: EdgeInsets.symmetric(
            vertical: widget.deviceSize.height / 32,
            horizontal: widget.deviceSize.width / 16,
          ),
          child: const Text(
              style: TextStyle(
                fontSize: 20,
                color: whiteColor,
              ),
              "You won't be able to change this later!"),
        ),
        Container(
          margin: EdgeInsets.only(
            left: widget.deviceSize.width / 16,
            right: widget.deviceSize.width / 16,
          ),
          padding: EdgeInsets.only(top: widget.deviceSize.height / 32),
          child: TextField(
            controller: nameTextBoxController,
            cursorColor: backgroundColor,
            keyboardAppearance: Brightness.dark,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Name',
              labelStyle: GoogleFonts.lato(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            keyboardType: TextInputType.name,
            onSubmitted: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
        ),
        ScreenGoToNextPageRow(
          "This will be shown on your profile!",
          "",
          () {
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setNextScreenActive();
            Provider.of<Profile>(context, listen: false).setName = _name;
            //Provider.of<Profile>(context, listen: false).createUserAPI();
          },
        )
      ],
    );
  }
}
