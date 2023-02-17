import 'package:dating_made_better/screens/newUser/gender_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/newUser/screen_heading_widget.dart';
import '../../widgets/newUser/screen_go_to_next_page_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstNameScreen extends StatefulWidget {
  const FirstNameScreen({super.key});
  static const routeName = '/first-name-screen';

  @override
  State<FirstNameScreen> createState() => _FirstNameScreenState();
}

class _FirstNameScreenState extends State<FirstNameScreen> {
  final nameTextBoxController = TextEditingController();
  void functionToSetName() {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('email')
        .add({
      'text': nameTextBoxController.text,
      'createdAt': DateTime.now(),
      'userId': user.uid,
    });
  }

  @override
  void dispose() {
    nameTextBoxController.dispose();
    super.dispose();
  }

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
            ScreenHeadingWidget("What's your first name?"),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 32,
                horizontal: MediaQuery.of(context).size.width / 16,
              ),
              child: const Text(
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(237, 237, 237, 1),
                  ),
                  "You won't be able to change this later!"),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 32),
              child: TextField(
                controller: nameTextBoxController,
                cursorColor: Color.fromRGBO(116, 91, 53, 1),
                keyboardAppearance: Brightness.dark,
                style: const TextStyle(
                  color: Color.fromRGBO(237, 237, 237, 1),
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
                onSubmitted: (value) {
                  final user = FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .collection('email')
                      .add({
                    'text': nameTextBoxController.text,
                    'createdAt': DateTime.now(),
                    'userId': user.uid,
                  });
                },
              ),
            ),
            ScreenGoToNextPageRow(
              "This will be shown on your profile!",
              GenderSelectionScreen.routeName,
              functionToSetName,
            )
          ],
        ),
      ),
    );
  }
}
