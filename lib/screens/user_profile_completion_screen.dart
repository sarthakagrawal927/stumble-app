import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final List<String> _images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmEQyguqPeNS0rFBoHIJ_JWFzAzN14Hk1R3e2xEEkr2g&s',
    'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=',
    'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'
  ];
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
      backgroundColor: const Color.fromRGBO(26, 28, 29, 0.5),
      appBar: const TopAppBar(),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                margin: const EdgeInsets.all(8),
                color: const Color.fromRGBO(26, 28, 29, 1),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 9,
                      vertical: MediaQuery.of(context).size.width / 12),
                  child: Column(
                    children: const [
                      Text(
                        textAlign: TextAlign.start,
                        'Profile completion',
                        style: TextStyle(
                          color: Color.fromRGBO(237, 237, 237, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          '20%',
                          style: TextStyle(
                            color: Color.fromRGBO(237, 237, 237, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8),
                color: const Color.fromRGBO(26, 28, 29, 1),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 9,
                      vertical: MediaQuery.of(context).size.width / 12),
                  child: Column(
                    children: <Widget>[
                      const Icon(
                        Icons.verified_sharp,
                        color: Colors.blueAccent,
                      ),
                      isProfileVerified
                          ? const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                'Verified',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color.fromRGBO(237, 237, 237, 1),
                                  fontSize: 15,
                                ),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
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
            ],
          ),
          const Divider(),
          Container(
            color: const Color.fromRGBO(26, 28, 29, 1),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 12),
                  child: const Text(
                    textAlign: TextAlign.start,
                    'Your pretty face',
                    style: TextStyle(
                      color: Color.fromRGBO(237, 237, 237, 1),
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
            padding: const EdgeInsets.only(bottom: 60),
            color: const Color.fromRGBO(26, 28, 29, 1),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Few things you should come talk to me about!',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color.fromRGBO(237, 237, 237, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color.fromRGBO(237, 237, 237, 1)),
                        initialValue: '',
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => {
                          FocusScope.of(context)
                              .requestFocus(_conversationStarterFocusNode)
                        },
                        // Todo: onSaved and validations
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
