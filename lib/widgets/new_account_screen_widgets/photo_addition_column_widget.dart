import 'dart:io';

import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/image_input.dart';
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
  @override
  Widget build(BuildContext context) {
    List<File> imageUrls =
        Provider.of<Profile>(context, listen: false).getImageUrls;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("Add your first photo!"),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
        ImageInput(imageUrls).renderButton(context, 0),
        ScreenGoToNextPageRow(
          "This is displayed on your profile",
          "",
          () {
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setisFirstPhotoSubmittedValue = true;
          },
        ),
      ],
    );
  }
}
