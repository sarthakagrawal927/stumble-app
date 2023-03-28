import 'package:flutter/material.dart';
import '../../widgets/newUser/screen_heading_widget.dart';
import '../../widgets/newUser/screen_go_to_next_page_row.dart';
import '../swiping_screen.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});
  static const routeName = "/permissions-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 28, 29, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 16,
          horizontal: MediaQuery.of(context).size.width / 16,
        ),
        child: ListView(
          children: [
            const ScreenHeadingWidget("Allow Permissions!"),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            ScreenGoToNextPageRow(
              "This is displayed on your profile",
              SwipingScreen.routeName,
              () {},
            ),
          ],
        ),
      ),
    );
  }
}
