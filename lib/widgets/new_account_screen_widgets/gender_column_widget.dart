import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';
import '../../providers/first_screen_state_providers.dart';
import '../../widgets/newUser/screen_heading_widget.dart';
import '../../widgets/newUser/screen_go_to_next_page_row.dart';

// ignore: must_be_immutable
class GenderColumn extends StatefulWidget {
  Size deviceSize;
  GenderColumn(this.deviceSize, {super.key});

  @override
  State<GenderColumn> createState() => _GenderColumnState();
}

class _GenderColumnState extends State<GenderColumn> {
  Gender? _gender;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("What's your gender?"),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: widget.deviceSize.width / 24,
            vertical: widget.deviceSize.height / 16,
          ),
          child: const Text(
              style: TextStyle(fontSize: 20, color: whiteColor),
              "Pick which best describes you!"),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: widget.deviceSize.height / 48),
              child: genderListTile('Woman', Gender.woman, context),
            ),
            Padding(
              padding: EdgeInsets.only(top: widget.deviceSize.height / 48),
              child: genderListTile('Man', Gender.man, context),
            ),
            Padding(
              padding: EdgeInsets.only(top: widget.deviceSize.height / 48),
              child: genderListTile('Nonbinary', Gender.nonBinary, context),
            ),
          ],
        ),
        ScreenGoToNextPageRow(
          "This will be shown on your profile!",
          "",
          () {
            handleSnackBarIfInputNotFilled(_gender != null, () async {
              Provider.of<FirstScreenStateProviders>(context, listen: false)
                  .setNextScreenActive();
              Provider.of<Profile>(context, listen: false).setGender =
                  _gender as Gender;
            }, context, valueToFill: "gender");
          },
        )
      ],
    );
  }

  RadioListTile genderListTile(
      String text, Gender gender, BuildContext context) {
    return RadioListTile<Gender>(
      tileColor: Colors.white,
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      onChanged: (Gender? value) {
        setState(() {
          _gender = value;
          Provider.of<Profile>(context, listen: false).setGender =
              _gender as Gender;
        });
      },
      value: gender,
      groupValue: _gender,
    );
  }
}
