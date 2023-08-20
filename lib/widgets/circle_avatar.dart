import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircleAvatarWidget extends StatelessWidget {
  String imageUrl = defaultBackupImage;
  CircleAvatarWidget(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: MediaQuery.of(context).size.width / 16,
      maxRadius: MediaQuery.of(context).size.width / 16,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
