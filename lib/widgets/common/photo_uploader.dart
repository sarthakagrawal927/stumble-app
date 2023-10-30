import 'dart:io';

import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoUploader extends StatefulWidget {
  final PhotoUploaderMode mode;
  const PhotoUploader(this.mode, {super.key});

  @override
  State<PhotoUploader> createState() => _PhotoUploaderState();
}

class _PhotoUploaderState extends State<PhotoUploader> {
  PhotoUploaderMode get mode => widget.mode;

  void addImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadPhotosAPI([File(pickedFile.path)]).then((filePaths) {
        Provider.of<Profile>(context, listen: false).addImage =
            File(filePaths.first);
      }).catchError((error) {
        debugPrint(error.toString());
      });
    }
  }

  bool thirdImageExists() {
    return Provider.of<Profile>(context).isThirdImagePresent();
  }

  bool firstImageExists() {
    return Provider.of<Profile>(context).isFirstImagePresent();
  }

  bool secondImageExists() {
    return Provider.of<Profile>(context).isSecondImagePresent();
  }

  String getFirstImageFilePath() {
    return Provider.of<Profile>(context).getFirstImageUrl.path;
  }

  String getSecondImageFilePath() {
    return Provider.of<Profile>(context).getSecondImageUrl.path;
  }

  String getThirdImageFilePath() {
    return Provider.of<Profile>(context).getThirdImageUrl.path;
  }

  Widget imageHandler(doesImageExist, String imagePath,
          {double heightMultiplier = 1 / 8, double widthMultiplier = 0.4}) =>
      Consumer<Profile>(
        builder: (context, value, child) => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widgetColor,
            fixedSize: Size(
              (MediaQuery.of(context).size.width) * widthMultiplier,
              (MediaQuery.of(context).size.height) * heightMultiplier,
            ),
          ),
          onPressed: addImageFromGallery,
          child: doesImageExist()
              ? Image.network(
                  imagePath,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                )
              : const Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    bool isSingleUpload = mode == PhotoUploaderMode.singleUpload;
    return Row(children: [
      imageHandler(firstImageExists, getFirstImageFilePath(),
          heightMultiplier: isSingleUpload ? 0.4 : 0.25,
          widthMultiplier: isSingleUpload ? 0.85 : 0.4),
      if (!isSingleUpload)
        Column(
          children: [
            imageHandler(secondImageExists, getSecondImageFilePath()),
            imageHandler(thirdImageExists, getThirdImageFilePath()),
          ],
        )
    ]);
  }
}
