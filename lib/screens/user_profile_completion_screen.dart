import 'dart:io';

import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  // final List<String> _images = [
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmEQyguqPeNS0rFBoHIJ_JWFzAzN14Hk1R3e2xEEkr2g&s',
  //   'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=',
  //   'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'
  // ];
  bool isProfileVerified = true;
  final _conversationStarterFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  File secondImageUrl = File("lmao");
  File thirdImageUrl = File("lmao");

  void getSecondImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    secondImageUrl = File("lmao");
    if (pickedFile != null) {
      secondImageUrl = File(pickedFile.path);
      // ignore: use_build_context_synchronously
      Provider.of<Profile>(context, listen: false).setSecondImage =
          secondImageUrl;
    }
  }

  void getThirdImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    thirdImageUrl = File("lmao");
    if (pickedFile != null) {
      thirdImageUrl = File(pickedFile.path);
      // ignore: use_build_context_synchronously
      Provider.of<Profile>(context, listen: false).setThirdImage =
          thirdImageUrl;
    }
  }

  bool secondImageExists() {
    if (Provider.of<Profile>(context, listen: false).isSecondImagePresent()) {
      Provider.of<Profile>(context, listen: false).setSecondImage =
          secondImageUrl;
      return true;
    }
    return false;
  }

  bool thirdImageExists() {
    if (Provider.of<Profile>(context, listen: false).isThirdImagePresent()) {
      Provider.of<Profile>(context, listen: false).setThirdImage =
          thirdImageUrl;
      return true;
    }
    return false;
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 15, 15, 0.2),
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
                color: const Color.fromRGBO(15, 15, 15, 1),
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
                        child: const Text(
                          textAlign: TextAlign.start,
                          '20%',
                          style: TextStyle(
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
                  color: const Color.fromRGBO(15, 15, 15, 1),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 16,
                        vertical: MediaQuery.of(context).size.width / 16),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.verified_sharp,
                          color: Colors.blueAccent,
                        ),
                        isProfileVerified
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.width / 20),
                                child: const Text(
                                  'Verified',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.width / 20),
                                child: const Text(
                                  'Verify my profile',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
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
            color: const Color.fromRGBO(15, 15, 15, 1),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 16),
                  child: const Text(
                    textAlign: TextAlign.start,
                    'Your pretty face!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(15, 15, 15, 0.5),
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
                      ),
                    ),
                    Column(
                      children: [
                        Consumer<Profile>(
                          builder: (context, value, child) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(15, 15, 15, 0.5),
                              fixedSize: Size(
                                (MediaQuery.of(context).size.width) * 0.4375,
                                (MediaQuery.of(context).size.height) / 8,
                              ),
                            ),
                            onPressed: getSecondImageFromGallery,
                            child: secondImageExists()
                                ? Image.file(
                                    secondImageUrl,
                                    fit: BoxFit.fill,
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
                              backgroundColor:
                                  const Color.fromRGBO(15, 15, 15, 0.5),
                              fixedSize: Size(
                                (MediaQuery.of(context).size.width) * 0.4375,
                                (MediaQuery.of(context).size.height) / 8,
                              ),
                            ),
                            onPressed: getThirdImageFromGallery,
                            child: thirdImageExists()
                                ? Image.file(
                                    thirdImageUrl,
                                    fit: BoxFit.fill,
                                  )
                                : const Icon(
                                    Icons.camera,
                                    color: Colors.white70,
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
            color: const Color.fromRGBO(15, 15, 15, 1),
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 16),
              child: Form(
                  key: _form,
                  child: AskMeAboutTextField(
                      _conversationStarterFocusNode, context)),
            ),
          ),
        ],
      ),
    );
  }
}
