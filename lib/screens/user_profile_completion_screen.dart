import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/profile.dart';
import '../widgets/image_input.dart';

class UserProfileCompletionScreen extends StatefulWidget {
  static const routeName = '/user-profile-completion';

  UserProfileCompletionScreen({super.key});

  @override
  State<UserProfileCompletionScreen> createState() =>
      _UserProfileCompletionScreenState();
}

class _UserProfileCompletionScreenState
    extends State<UserProfileCompletionScreen> {
  File? imageFile;
  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  final List<String> _images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmEQyguqPeNS0rFBoHIJ_JWFzAzN14Hk1R3e2xEEkr2g&s',
    'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=',
    'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'
  ];

  final _secondConversationStarterFocusNode = FocusNode();
  final _thirdConversationStarterFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _secondConversationStarterFocusNode.dispose();
    _thirdConversationStarterFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Dating, made better!',
          textAlign: TextAlign.left,
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
          Row(
            children: [
              imageFile == null
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          (MediaQuery.of(context).size.width) / 2,
                          (MediaQuery.of(context).size.height) / 4,
                        ),
                      ),
                      onPressed: _getFromGallery,
                      child: const Icon(
                        Icons.camera,
                      ),
                    )
                  : Container(
                      child: Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: (MediaQuery.of(context).size.width) / 2,
                      height: (MediaQuery.of(context).size.height) / 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(_images[1]),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: (MediaQuery.of(context).size.width) / 2,
                      height: (MediaQuery.of(context).size.height) / 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(_images[2]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
                          .requestFocus(_secondConversationStarterFocusNode)
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
