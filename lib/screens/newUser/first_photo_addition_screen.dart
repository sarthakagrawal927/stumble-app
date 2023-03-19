import 'package:dating_made_better/screens/newUser/profile_prompt_addition_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/newUser/screen_heading_widget.dart';
import '../../widgets/newUser/screen_go_to_next_page_row.dart';
import '../../providers/image_input.dart';

class FirstPhotoAdditionScreen extends StatelessWidget {
  const FirstPhotoAdditionScreen({super.key});
  static const routeName = '/first-photo-screen';

  void functionToSetFirstImage() {}

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
            const ScreenHeadingWidget("Add your first photo!"),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            ImageInput().renderButton(context, 0),
            ScreenGoToNextPageRow(
              "This is displayed on your profile",
              ProfilePromptAdditionScreen.routeName,
              functionToSetFirstImage,
            ),
          ],
        ),
      ),
    );
  }
}
