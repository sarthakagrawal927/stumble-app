import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircleAvatarWidget extends StatelessWidget {
  String imageUrl =
      'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg';
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
