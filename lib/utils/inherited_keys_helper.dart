import 'package:flutter/material.dart';

class InheritedKeysHelper extends InheritedWidget {
  const InheritedKeysHelper({
    super.key,
    required this.locationUsageKey,
    required this.dropDownKey,
    required this.profileLikeKey,
    required this.profileDislikeKey,
    required super.child,
  });

  final GlobalKey locationUsageKey;
  final GlobalKey dropDownKey;
  final GlobalKey profileLikeKey;
  final GlobalKey profileDislikeKey;

  static InheritedKeysHelper of(BuildContext context) {
    return context.getInheritedWidgetOfExactType<InheritedKeysHelper>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}
