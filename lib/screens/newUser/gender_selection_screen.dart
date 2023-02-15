import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

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
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 32,
                horizontal: MediaQuery.of(context).size.width / 16,
              ),
              child: const Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromRGBO(116, 91, 53, 1),
                  ),
                  "What's your gender?"),
            ),
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
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 32),
              child: genderListTile('Woman', Gender.woman),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 32),
              child: genderListTile('Man', Gender.man),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 32),
              child: genderListTile('Nonbinary', Gender.nonBinary),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      size: MediaQuery.of(context).size.width / 16,
                      color: Color.fromRGBO(116, 91, 53, 1),
                    ),
                    const Text(
                      "This will be shown on your profile!",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(237, 237, 237, 1)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(26, 28, 29, 1),
                      ),
                      onPressed: (() {
                        Navigator.pushReplacementNamed(
                            context, SwipingScreen.routeName);
                      }),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color.fromRGBO(116, 91, 53, 1),
                        size: MediaQuery.of(context).size.width / 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
        style: TextStyle(
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
