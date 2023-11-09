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
  int isLoading = 0;

  void addImageFromGallery([int imagePos = 1]) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadPhotosAPI([File(pickedFile.path)]).then((filePaths) {
        Provider.of<Profile>(context, listen: false).setImageAtPosition(
          File(filePaths[0]),
          imagePos,
        );
      }).catchError((error) {
        debugPrint(error.toString());
      });
    }
  }

  Widget imageHandler(int imagePos,
      {double heightMultiplier = 1 / 8, double widthMultiplier = 0.4}) {
    bool doesImageExist =
        Provider.of<Profile>(context).isImageAtPosPresent(imagePos);
    String imagePath =
        Provider.of<Profile>(context).getImageAtPos(imagePos).path;
    return Consumer<Profile>(
      builder: (context, value, child) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widgetColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
          fixedSize: Size(
            (MediaQuery.of(context).size.width) * widthMultiplier,
            (MediaQuery.of(context).size.height) * heightMultiplier,
          ),
        ),
        onPressed: () async => addImageFromGallery(imagePos),
        child: doesImageExist
            ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : const Icon(
                Icons.camera,
                color: Colors.white,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSingleUpload = mode == PhotoUploaderMode.singleUpload;
    return Row(children: [
      imageHandler(1,
          heightMultiplier: isSingleUpload ? 0.4 : 0.25,
          widthMultiplier: isSingleUpload ? 0.85 : 0.4),
      if (!isSingleUpload) ...[
        const Spacer(),
        Column(
          children: [
            imageHandler(2),
            const SizedBox(height: 10),
            imageHandler(3),
          ],
        )
      ]
    ]);
  }
}
