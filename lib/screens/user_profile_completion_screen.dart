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
      appBar: const TopAppBar(),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 64,
                  left: MediaQuery.of(context).size.width / 16,
                  right: MediaQuery.of(context).size.width / 32,
                ),
                color: widgetColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 16,
                      vertical: MediaQuery.of(context).size.width / 16),
                  child: Column(
                    children: [
                      const Text(
                        textAlign: TextAlign.start,
                        'Profile completion',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 16),
                        child: Text(
                          textAlign: TextAlign.start,
                          "$profileCompletionPercentage%",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 64,
                    left: MediaQuery.of(context).size.width / 32,
                    right: MediaQuery.of(context).size.width / 16,
                  ),
                  color: widgetColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 16,
                        vertical: MediaQuery.of(context).size.width / 16),
                    child: isProfileVerified
                        ? Column(
                            children: <Widget>[
                              const Icon(
                                Icons.verified_sharp,
                                color: Colors.blueAccent,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.width / 20),
                                child: const Text(
                                  'Verified',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              const Icon(
                                Icons.verified_outlined,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.width / 20),
                                child: const Text(
                                  'Verify my profile',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 16,
            ),
            color: widgetColor,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 16),
                  child: const Text(
                    textAlign: TextAlign.start,
                    'Your pretty face!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PhotoUploader(PhotoUploaderMode.multiUpload),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 16,
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 16),
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
                  "dob": Provider.of<Profile>(context, listen: false)
                      .getBirthDate
                      .toIso8601String()
                }).then((value) {
                  Navigator.of(context).pop();
                }).catchError((error) {
                  debugPrint(error.toString());
                });
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
