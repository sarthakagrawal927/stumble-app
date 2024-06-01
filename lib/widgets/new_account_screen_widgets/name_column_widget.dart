import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/constants_font_sizes.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
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
  String _name = "";

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
        const ScreenHeadingWidget("What should your 'stumblers' call you?"),
        Container(
          margin: EdgeInsets.only(
            left: marginWidth16(context),
            right: marginWidth16(context),
          ),
          padding: EdgeInsets.symmetric(
            vertical: marginHeight32(context),
            horizontal: marginWidth16(context),
          ),
          child: Text(
              style: TextStyle(
                fontSize: fontSize48(context),
                color: whiteColor,
              ),
              "You won't be able to change this later!"),
        ),
        Container(
          margin: EdgeInsets.only(
            left: marginWidth16(context),
            right: marginWidth16(context),
          ),
          padding: EdgeInsets.only(top: marginHeight32(context)),
          child: TextField(
            controller: nameTextBoxController,
            cursorColor: backgroundColor,
            style: TextStyle(
              color: whiteColor,
              fontSize: fontSize32(context),
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: whiteColor,
              )),
              labelText: 'Name',
              labelStyle: GoogleFonts.lato(
                fontSize: fontSize48(context),
                color: whiteColor,
              ),
            ),
            keyboardType: TextInputType.name,
            autofocus: true,
            onChanged: (value) {
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
            handleSnackBarIfInputNotFilled(_name != "", () async {
              Provider.of<FirstScreenStateProviders>(context, listen: false)
                  .setNextScreenActive();
              Provider.of<Profile>(context, listen: false).setName = _name;
            }, context, valueToFill: "name");
          },
        )
      ],
    );
  }
}
