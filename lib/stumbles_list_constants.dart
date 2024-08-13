import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';

BoxDecoration imageBoxWidget(BuildContext context, String? imageUrl) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.secondary,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(imageUrl ?? defaultBackupImage),
    ),
  );
}
