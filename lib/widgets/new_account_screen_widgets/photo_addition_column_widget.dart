import 'dart:io';

import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/profile.dart';
import '../newUser/screen_heading_widget.dart';
import '../newUser/screen_go_to_next_page_row.dart';

// ignore: must_be_immutable
class PhotoAdditionColumn extends StatefulWidget {
  Size deviceSize;
  PhotoAdditionColumn(this.deviceSize, {super.key});

  @override
  State<PhotoAdditionColumn> createState() => _PhotoAdditionColumnState();
}

class _PhotoAdditionColumnState extends State<PhotoAdditionColumn> {
  late File imageUrl;

  void getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    imageUrl = File("lmao");
    if (pickedFile != null) {
      imageUrl = File(pickedFile.path);
      // ignore: use_build_context_synchronously
      Provider.of<Profile>(context, listen: false).setFirstImage = imageUrl;
    }
  }

  bool elemenExistsAt() {
    return Provider.of<Profile>(context, listen: false).isFirstImagePresent();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("Add your first photo!"),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
        Consumer<Profile>(
          builder: (context, value, child) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(15, 15, 15, 0.5),
              fixedSize: Size(
                (MediaQuery.of(context).size.width) * 10 / 16,
                (MediaQuery.of(context).size.height) / 4,
              ),
            ),
            onPressed: getFromGallery,
            child: elemenExistsAt()
                ? Image.file(
                    imageUrl,
                    fit: BoxFit.fill,
                  )
                : const Icon(
                    Icons.camera,
                    color: Colors.white70,
                  ),
          ),
        ),
        ScreenGoToNextPageRow(
          "This is displayed on your profile",
          "",
          () {
            Provider.of<Profile>(context, listen: false).setFirstImage =
                imageUrl;
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setisFirstPhotoSubmittedValue = true;
          },
        ),
      ],
    );
  }
}
