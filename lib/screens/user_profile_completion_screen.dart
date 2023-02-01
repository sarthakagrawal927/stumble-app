import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/image_input.dart';
import '../providers/profile.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Stumble!',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 12),
            child: const Text(
              textAlign: TextAlign.start,
              'Profile completion: 20%',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 12),
            child: const Text(
              textAlign: TextAlign.start,
              'Photos and videos',
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
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              Icon(
                Icons.verified_sharp,
                color: Colors.blueAccent,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Verify my profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Text(
                'Verified',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'A few things you should come talk to me about!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
