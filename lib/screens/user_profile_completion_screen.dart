import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/ask_me_about_text_field.dart';
import '../providers/image_input.dart';

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
    ImageInput imageInput = Provider.of<ImageInput>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
                color: Colors.white,
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
                          color: Colors.black,
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
                            color: Colors.black,
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
                  color: Colors.white,
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
                                    color: Colors.black,
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
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 16),
                  child: const Text(
                    textAlign: TextAlign.start,
                    'Your pretty face!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<ImageInput>(
                  builder: (context, value, child) => IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        imageInput.renderButton(context, 0),
                        IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              imageInput.renderButton(context, 1),
                              imageInput.renderButton(context, 2),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width / 16),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 16),
            color: Colors.white,
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
