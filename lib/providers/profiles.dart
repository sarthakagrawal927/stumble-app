import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './profile.dart';
import '../constants.dart';

class Profiles with ChangeNotifier {
  List<Profile> userProfiles = [
    Profile(
      id: '2',
      age: 22,
      gender: Gender.man,
      name: 'Sarthak',
      imageUrls: [
        File(
            'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
        File(
            'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=')
      ],
      isVerified: false,
      conversationStarterPrompt: "",
    ),
    Profile(
      id: '1',
      age: 22,
      name: 'Rahul',
      gender: Gender.man,
      imageUrls: [
        File(
            'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
        File(
            'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
      ],
      isVerified: false,
      conversationStarterPrompt: "",
    ),
    Profile(
      id: '3',
      age: 22,
      name: 'Kshitij',
      gender: Gender.nonBinary,
      imageUrls: [
        File(
            'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
        File(
            'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=')
      ],
      isVerified: false,
      conversationStarterPrompt: "",
    ),
  ];
}
