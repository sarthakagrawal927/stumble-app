import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  final String id;
  final String name;
  final double age;
  final String imageUrl;
  bool isVerified;
  final List<String> conversationStarterList;

  Profile({
    required this.id,
    required this.name,
    required this.age,
    this.isVerified = false,
    required this.imageUrl,
    required this.conversationStarterList,
  });
}
