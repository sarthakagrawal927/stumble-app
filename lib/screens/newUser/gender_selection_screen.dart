import 'package:dating_made_better/screens/newUser/first_photo_addition_screen.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../widgets/newUser/screen_heading_widget.dart';
import '../../widgets/newUser/screen_go_to_next_page_row.dart';

enum Gender { woman, man, nonBinary }

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
      backgroundColor: Color.fromRGBO(26, 28, 29, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 16,
          horizontal: MediaQuery.of(context).size.width / 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ScreenHeadingWidget("What's your gender?"),
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
                  child: genderListTile('Woman', Gender.woman),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 48),
                  child: genderListTile('Man', Gender.man),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 48),
                  child: genderListTile('Nonbinary', Gender.nonBinary),
                ),
              ],
            ),
            ScreenGoToNextPageRow("You can always update this later!",
                FirstPhotoAdditionScreen.routeName),
          ],
        ),
      ),
    );
  }

  ListTile genderListTile(String text, Gender gender) {
    return ListTile(
      iconColor: Color.fromRGBO(116, 91, 53, 1),
      tileColor: Color.fromRGBO(26, 28, 29, 0.5),
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
          });
        },
      ),
    );
  }
}
