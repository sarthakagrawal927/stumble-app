import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:flutter/material.dart';

BoxDecoration imageBoxWidget(BuildContext context, MiniProfile profile) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.secondary,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(profile.photo ?? defaultBackupImage),
    ),
  );
}
