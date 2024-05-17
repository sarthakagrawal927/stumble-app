import 'dart:io';

import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:exif/exif.dart';
import 'package:image/image.dart' as img;

Future<void> applyRotationFix(String originalPath) async {
  try {
    Map<String, IfdTag> data = await readExifFromFile(File(originalPath));
    print(data);

    int length = int.parse(data['EXIF ExifImageLength'].toString());
    int width = int.parse(data['EXIF ExifImageWidth'].toString());
    String orientation = data['Image Orientation'].toString();

    img.Image? original = img.decodeImage(File(originalPath).readAsBytesSync());
    if (length > width) {
      if (orientation.contains('Rotated 90 CW')) {
        img.Image fixed = img.copyRotate(original!, angle: -90);
        File(originalPath).writeAsBytesSync(img.encodeJpg(fixed));
      } else if (orientation.contains('Rotated 180 CW')) {
        img.Image fixed = img.copyRotate(original!, angle: -180);
        File(originalPath).writeAsBytesSync(img.encodeJpg(fixed));
      } else if (orientation.contains('Rotated 270 CW')) {
        img.Image fixed = img.copyRotate(original!, angle: -270);
        File(originalPath).writeAsBytesSync(img.encodeJpg(fixed));
      }
    }
  } catch (e) {
    print(e.toString());
  }
}

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
      await applyRotationFix(pickedFile.path);
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

  // (3 / 10) - (1 / 64) = (91 / 640)
  Widget imageHandler(int imagePos,
      {double heightMultiplier = 0.15, double widthMultiplier = 15 / 32}) {
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
                color: textColor,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSingleUpload = mode == PhotoUploaderMode.singleUpload;
    return Row(children: [
      imageHandler(1,
          heightMultiplier: isSingleUpload ? 0.4 : 0.30,
          widthMultiplier: isSingleUpload ? 0.85 : 15 / 32),
      if (!isSingleUpload) ...[
        Column(
          children: [
            imageHandler(2),
            imageHandler(3),
          ],
        )
      ]
    ]);
  }
}
