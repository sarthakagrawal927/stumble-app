import 'dart:io';

import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final _form = GlobalKey<FormState>();

  File secondImageUrl = File("");
  File thirdImageUrl = File("");

  void getSecondImageFromGallery(BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      secondImageUrl = File(pickedFile.path);
      if (context.mounted) {
        Provider.of<Profile>(context, listen: false).setSecondImage =
            secondImageUrl;
        Provider.of<Profile>(context, listen: false).uploadPhotosAPI(2);
      }
    }
  }

  void getThirdImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      thirdImageUrl = File(pickedFile.path);
      if (context.mounted) {
        Provider.of<Profile>(context, listen: false).setThirdImage =
            thirdImageUrl;
        Provider.of<Profile>(context, listen: false).uploadPhotosAPI(3);
      }
    }
  }

  bool secondImageExists() {
    return Provider.of<Profile>(context).isSecondImagePresent();
  }

  bool thirdImageExists() {
    return Provider.of<Profile>(context).isThirdImagePresent();
  }

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
        Provider.of<Profile>(context).getPercentageOfProfileCompleted.toInt();
    String conversationStarterPrompt =
        Provider.of<Profile>(context).getConversationStarterPrompt;
    bool isProfileVerified =
        Provider.of<Profile>(context).getPhotoVerificationStatus;
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
                  top: MediaQuery.of(context).size.width / 16,
                  bottom: MediaQuery.of(context).size.width / 16,
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
                    top: MediaQuery.of(context).size.width / 16,
                    bottom: MediaQuery.of(context).size.width / 16,
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
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widgetColor,
                        fixedSize: Size(
                          (MediaQuery.of(context).size.width) * 0.4375,
                          (MediaQuery.of(context).size.height) / 4,
                        ),
                      ),
                      onPressed: () {},
                      child: Image.file(
                        Provider.of<Profile>(context, listen: false)
                            .getFirstImageUrl,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Column(
                      children: [
                        Consumer<Profile>(
                          builder: (context, value, child) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widgetColor,
                              fixedSize: Size(
                                (MediaQuery.of(context).size.width) * 0.4375,
                                (MediaQuery.of(context).size.height) / 8,
                              ),
                            ),
                            onPressed: () async {
                              getSecondImageFromGallery(context);
                              Provider.of<Profile>(context, listen: false)
                                  .setSecondImage = secondImageUrl;
                              Provider.of<Profile>(context, listen: false)
                                  .uploadPhotosAPI(2);
                            },
                            child: secondImageExists()
                                ? Image.file(
                                    Provider.of<Profile>(context, listen: false)
                                        .getSecondImageUrl,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : const Icon(
                                    Icons.camera,
                                    color: Colors.white70,
                                  ),
                          ),
                        ),
                        Consumer<Profile>(
                          builder: (context, value, child) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widgetColor,
                              fixedSize: Size(
                                (MediaQuery.of(context).size.width) * 0.4375,
                                (MediaQuery.of(context).size.height) / 8,
                              ),
                            ),
                            onPressed: getThirdImageFromGallery,
                            child: thirdImageExists()
                                ? Image.file(
                                    Provider.of<Profile>(context, listen: false)
                                        .getThirdImageUrl,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : const Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 16,
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 16,
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 16),
            color: widgetColor,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 16),
              child: Form(
                  key: _form,
                  child: AskMeAboutTextField(_conversationStarterFocusNode,
                      context, conversationStarterPrompt)),
            ),
          ),
        ],
      ),
    );
  }
}
