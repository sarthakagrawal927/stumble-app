import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/widgets/common/photo_uploader.dart';
import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile.dart';
import '../newUser/screen_go_to_next_page_row.dart';
import '../newUser/screen_heading_widget.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("Add your first photo!"),
        SizedBox(
          height: marginHeight16(context),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [PhotoUploader(PhotoUploaderMode.singleUpload)],
        ),
        ScreenGoToNextPageRow(
          "This is displayed on your profile",
          "",
          () {
            handleSnackBarIfInputNotFilled(
                Provider.of<Profile>(context, listen: false)
                    .isImageAtPosPresent(1), () async {
              Provider.of<FirstScreenStateProviders>(context, listen: false)
                  .setNextScreenActive();
            }, context, valueToFill: "photo");
          },
        ),
      ],
    );
  }
}
