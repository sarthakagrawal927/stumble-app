import 'package:flutter/material.dart';

import 'first_name_screen.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});
  static const routeName = '/terms-and-conditions-screen';

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
              child:
                  Icon(Icons.lock, size: MediaQuery.of(context).size.width / 3),
            ),
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
                  "We care about your privacy!"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 32,
                horizontal: MediaQuery.of(context).size.width / 16,
              ),
              child: const Text(
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(237, 237, 237, 1)),
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore "),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(26, 28, 29, 0),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height / 16,
                    ),
                  ),
                  onPressed: (() {
                    Navigator.of(context)
                        .pushReplacementNamed(FirstNameScreen.routeName);
                  }),
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(116, 91, 53, 1),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(26, 28, 29, 0),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height / 16,
                    ),
                  ),
                  onPressed: (() {
                    // Future work
                  }),
                  child: const Text(
                    "Reject",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(57, 66, 70, 1),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
