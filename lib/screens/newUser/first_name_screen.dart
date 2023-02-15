import 'package:dating_made_better/screens/newUser/gender_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstNameScreen extends StatelessWidget {
  const FirstNameScreen({super.key});
  static const routeName = '/first-name-screen';
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
                  "What's your first name?"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 32,
                horizontal: MediaQuery.of(context).size.width / 16,
              ),
              child: const Text(
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(237, 237, 237, 1)),
                  "You won't be able to change this later!"),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 32),
              child: TextField(
                cursorColor: Color.fromRGBO(116, 91, 53, 1),
                keyboardAppearance: Brightness.dark,
                style: const TextStyle(
                  color: Color.fromRGBO(116, 91, 53, 1),
                  fontSize: 35,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ex: Daddy :)',
                  labelStyle: GoogleFonts.lato(
                    fontSize: 25,
                    color: Color.fromRGBO(116, 91, 53, 1),
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
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
                        Navigator.of(context).pushReplacementNamed(
                            GenderSelectionScreen.routeName);
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
}
