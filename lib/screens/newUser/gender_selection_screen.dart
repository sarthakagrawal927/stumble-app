import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './first_photo_addition_screen.dart';
import '../../constants.dart';
import '../../providers/profile.dart';
import '../../widgets/newUser/screen_heading_widget.dart';
import '../../widgets/newUser/screen_go_to_next_page_row.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});
  static const routeName = '/gender-selection-screen';

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  Gender? _gender = Gender.woman;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 28, 29, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 16,
          horizontal: MediaQuery.of(context).size.width / 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ScreenHeadingWidget("What's your gender?"),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 32,
                horizontal: MediaQuery.of(context).size.width / 16,
              ),
              child: const Text(
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(237, 237, 237, 1)),
                  "Pick which best describes you! Then add more about your gender if you'd like."),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 48),
                  child: genderListTile('Woman', Gender.woman, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 48),
                  child: genderListTile('Man', Gender.man, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 48),
                  child: genderListTile('Nonbinary', Gender.nonBinary, context),
                ),
              ],
            ),
            ScreenGoToNextPageRow(
              "You can always update this later!",
              FirstPhotoAdditionScreen.routeName,
              () => Provider.of<Profile>(context, listen: false).setGender =
                  _gender as Gender,
            ),
          ],
        ),
      ),
    );
  }

  ListTile genderListTile(String text, Gender gender, BuildContext context) {
    return ListTile(
      iconColor: const Color.fromRGBO(116, 91, 53, 1),
      tileColor: const Color.fromRGBO(26, 28, 29, 0.5),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          color: Color.fromRGBO(116, 91, 53, 1),
        ),
      ),
      leading: Radio<Gender>(
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
