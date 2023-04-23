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
  Gender? _gender = Gender.woman;

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
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(237, 237, 237, 1)),
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
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setisGenderSubmittedValue = true;
            Provider.of<Profile>(context, listen: false).setGender =
                _gender as Gender;
          },
        )
      ],
    );
  }

  ListTile genderListTile(String text, Gender gender, BuildContext context) {
    return ListTile(
      iconColor: Colors.white,
      tileColor: Colors.white,
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      leading: Radio<Gender>(
        fillColor: MaterialStateColor.resolveWith(
            (states) => const Color.fromRGBO(15, 15, 15, 1)),
        value: gender,
        groupValue: _gender,
        onChanged: (Gender? value) {
          setState(() {
            _gender = value;
            Provider.of<Profile>(context, listen: false).setGender =
                _gender as Gender;
          });
        },
      ),
    );
  }
}
