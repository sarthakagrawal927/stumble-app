import 'dart:io';

import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/common/photo_uploader.dart';
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
  bool hasSubmittedImageForVerification = false;

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
        marginWidth24(context),
      ),
      child: Text(
        textAlign: TextAlign.start,
        profileCompletionPercentage,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize32(context),
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
    PhotoVerificationStatus photoVerificationStatus =
        Provider.of<Profile>(context, listen: false).getPhotoVerificationStatus;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: TopAppBar(
        centerTitle: true,
        showActions: false,
        showLeading: true,
        heading: "Profile Edit",
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
                  top: marginWidth32(context),
                  left: marginWidth32(context),
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
                  top: marginWidth32(context),
                  right: marginWidth32(context),
                ),
                child: Consumer<Profile>(
                  builder: (context, value, child) => GestureDetector(
                    onTap: () async {
                      if (photoVerificationStatus ==
                              PhotoVerificationStatus.needToVerify ||
                          photoVerificationStatus ==
                              PhotoVerificationStatus.rejected) {
                        addImageFromGallery()
                            .then((file) => verifyPhotoAPI(file))
                            .then((isVerified) => {
                                  Provider.of<Profile>(context, listen: false)
                                          .photoVerificationStatus =
                                      PhotoVerificationStatus.pending
                                });
                      }
                    },
                    child: verificationStatusCard(
                      context,
                      photoVerificationStatus,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.4,
            width: MediaQuery.of(context).size.width / 1.125,
            margin: EdgeInsets.only(
              top: marginWidth32(context),
              left: marginWidth32(context),
              right: marginWidth32(context),
            ),
            color: widgetColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    marginWidth32(context),
                  ),
                  child: Text(
                    textAlign: TextAlign.start,
                    'Your clicks!',
                    style: TextStyle(
                      color: textColor,
                      fontSize: marginWidth16(context),
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
              top: marginWidth32(context),
              left: marginWidth32(context),
              right: marginWidth32(context),
            ),
            padding: EdgeInsets.all(marginWidth32(context)),
            color: widgetColor,
            child: Padding(
              padding: EdgeInsets.only(top: marginWidth32(context)),
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
              top: marginHeight64(context),
            ),
            padding: EdgeInsets.only(
              left: marginWidth16(context),
              right: marginWidth16(context),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor),
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
                style:
                    TextStyle(fontSize: 20, color: AppColors.backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<File> addImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return File("");
  }
}

class PhotoVerificationView {
  final String text;
  final Color color;
  final IconData icon;

  PhotoVerificationView({
    required this.text,
    required this.color,
    required this.icon,
  });
}

final photoVerificationStatusToTextMap = {
  PhotoVerificationStatus.needToVerify: PhotoVerificationView(
      color: Colors.red, icon: Icons.warning, text: "Verify"),
  PhotoVerificationStatus.pending: PhotoVerificationView(
      color: Colors.red, icon: Icons.warning, text: "Verify"),
  PhotoVerificationStatus.verified: PhotoVerificationView(
      color: Colors.red, icon: Icons.warning, text: "Verify"),
  PhotoVerificationStatus.rejected: PhotoVerificationView(
      color: Colors.red, icon: Icons.warning, text: "Verify"),
};

Card verificationStatusCard(
  BuildContext context,
  PhotoVerificationStatus photoVerificationStatus,
) {
  return Card(
    color: widgetColor,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: marginWidth32(context),
        vertical: marginWidth32(context),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(
              marginWidth16(context),
            ),
            child: Icon(
              size: fontSize32(context),
              photoVerificationStatusToTextMap[photoVerificationStatus]!.icon,
              color: photoVerificationStatusToTextMap[photoVerificationStatus]!
                  .color,
            ),
          ),
          Text(
            photoVerificationStatusToTextMap[photoVerificationStatus]!.text,
            textAlign: TextAlign.end,
            style: AppTextStyles.descriptionText(context),
          ),
        ],
      ),
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
        marginWidth32(context),
      ),
      child: Column(
        children: [
          widgetToRender,
          Text(
            text,
            textAlign: TextAlign.end,
            style: AppTextStyles.descriptionText(
              context,
            ),
          ),
        ],
      ),
    ),
  );
}
