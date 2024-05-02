import 'package:dating_made_better/screens/user_profile_overview_screen.dart';
import 'package:dating_made_better/widgets/common/photo_uploader.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../widgets/ask_me_about_text_field.dart';

class UserProfileCompletionScreen extends StatefulWidget {
  static const routeName = '/user-profile-completion';

  const UserProfileCompletionScreen({super.key});

  @override
  State<UserProfileCompletionScreen> createState() =>
      _UserProfileCompletionScreenState();
}

class _UserProfileCompletionScreenState
    extends State<UserProfileCompletionScreen> {
  final _conversationStarterFocusNode = FocusNode();

  @override
  void dispose() {
    _conversationStarterFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Padding profileCompletionWidget(
    BuildContext context,
    String profileCompletionPercentage,
  ) {
    return Padding(
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width / 16,
      ),
      child: Text(
        textAlign: TextAlign.start,
        profileCompletionPercentage,
        style: TextStyle(
          color: textColor,
          fontSize: MediaQuery.of(context).size.width / 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int profileCompletionPercentage =
        Provider.of<Profile>(context, listen: false)
            .getPercentageOfProfileCompleted
            .toInt();
    String conversationStarterPrompt =
        Provider.of<Profile>(context, listen: false)
            .getConversationStarterPrompt;
    bool isProfileVerified =
        Provider.of<Profile>(context, listen: false).getPhotoVerificationStatus;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: TopAppBar(
        routeName: UserProfileScreen.routeName,
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 2.25,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 32,
                  left: MediaQuery.of(context).size.width / 32,
                ),
                child: profileCompletionCard(
                  context,
                  'Profile completion',
                  profileCompletionWidget(
                    context,
                    "$profileCompletionPercentage %",
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 2.25,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 32,
                  right: MediaQuery.of(context).size.width / 32,
                ),
                child: isProfileVerified
                    ? verificationStatusCard(
                        context,
                        Icons.verified_sharp,
                        Colors.blueAccent,
                        "Verified",
                      )
                    : verificationStatusCard(
                        context,
                        Icons.verified_outlined,
                        textColor,
                        "Verify my profile",
                      ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.4,
            width: MediaQuery.of(context).size.width / 1.125,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 32,
              left: MediaQuery.of(context).size.width / 32,
              right: MediaQuery.of(context).size.width / 32,
            ),
            color: widgetColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width / 32,
                  ),
                  child: Text(
                    textAlign: TextAlign.start,
                    'Your clicks!',
                    style: TextStyle(
                      color: textColor,
                      fontSize: MediaQuery.of(context).size.width / 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PhotoUploader(PhotoUploaderMode.multiUpload),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 32,
              left: MediaQuery.of(context).size.width / 32,
              right: MediaQuery.of(context).size.width / 32,
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 32),
            color: widgetColor,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 32),
              child: Consumer<Profile>(
                builder: (context, value, child) => AskMeAboutTextField(
                    _conversationStarterFocusNode,
                    context,
                    conversationStarterPrompt),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 64,
            ),
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 16,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: filterScreenTextColor),
              onPressed: () async {
                Provider.of<Profile>(context, listen: false).upsertUser({
                  "conversation_starter":
                      Provider.of<Profile>(context, listen: false)
                          .getConversationStarterPrompt,
                  "photos": Provider.of<Profile>(context, listen: false)
                      .getPhotos
                      .map((e) => e.path)
                      .toList(),
                }).then((value) {
                  Navigator.of(context).pop();
                }).catchError((error) {
                  debugPrint(error.toString());
                });
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 20, color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card verificationStatusCard(
    BuildContext context,
    IconData icon,
    Color color,
    String text,
  ) {
    return Card(
      color: widgetColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 32,
          vertical: MediaQuery.of(context).size.width / 32,
        ),
        child: Column(
          children: <Widget>[
            verificationIconToDisplay(context, icon, color),
            Text(
              text,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: textColor,
                fontSize: MediaQuery.of(context).size.width / 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding verificationIconToDisplay(
      BuildContext context, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width / 16,
      ),
      child: Icon(
        size: MediaQuery.of(context).size.width / 16,
        icon,
        color: color,
      ),
    );
  }

  Widget profileCompletionCard(
    BuildContext context,
    String text,
    Padding widgetToRender,
  ) {
    return Card(
      color: widgetColor,
      child: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width / 32,
        ),
        child: Column(
          children: [
            widgetToRender,
            Text(
              text,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: textColor,
                fontSize: MediaQuery.of(context).size.width / 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
