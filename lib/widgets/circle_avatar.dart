import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CircleAvatarWidget extends StatelessWidget {
  double radius;
  String imageUrl = defaultBackupImage;
  CircleAvatarWidget(this.radius, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      minRadius: radius,
      maxRadius: radius,
    );
  }
}
