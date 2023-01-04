import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  final String name;
  final double age;
  final String imageUrl;
  bool isVerified;

  Profile({
    required this.name,
    required this.age,
    this.isVerified = false,
    required this.imageUrl,
  });
}
