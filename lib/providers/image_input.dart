import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'profile.dart';

class ImageInput {
  late File imageUrl;

  File get getImageUrl {
    return imageUrl;
  }

  void setFirstImage(BuildContext context) {
    Provider.of<Profile>(context).setFirstImage = imageUrl;
  }

  void getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageUrl = File(pickedFile.path);
    }
  }

  bool elemenExistsAt(BuildContext context) {
    setFirstImage(context);
    return true;
  }

  Widget renderPhotoButtonForFirstImage(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(15, 15, 15, 0.5),
        fixedSize: Size(
          (MediaQuery.of(context).size.width) * 10 / 16,
          (MediaQuery.of(context).size.height) / 4,
        ),
      ),
      onPressed: getFromGallery,
      child: elemenExistsAt(context)
          ? Image.file(
              imageUrl,
              fit: BoxFit.fill,
            )
          : const Icon(
              Icons.camera,
              color: Colors.white70,
            ),
    );
  }

  // Widget renderButton(BuildContext context, int imageNumber) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
  //       fixedSize: Size(
  //         (MediaQuery.of(context).size.width) * 7 / 16,
  //         (MediaQuery.of(context).size.height) /
  //             (5 * (imageNumber != 0 ? 2 : 1)),
  //       ),
  //     ),
  //     onPressed: getFromGallery,
  //     child: elemenExistsAt()
  //         ? Image.file(
  //             imageUrl,
  //             fit: BoxFit.fill,
  //           )
  //         : const Icon(
  //             Icons.camera,
  //             color: Colors.white70,
  //           ),
  //   );
  // }
}
