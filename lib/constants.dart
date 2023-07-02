import 'dart:io';

import 'package:flutter/material.dart';

import 'providers/profile.dart';

enum Gender { woman, man, nonBinary }

enum Swipe { left, right, none }

enum SwipeType { swipe, comment, nicheSelection }

List<Profile> constantListOfStumbles = [
  Profile(
    id: '1',
    birthDate: "",
    name: 'A',
    phoneNumber: '1234567890',
    gender: Gender.man,
    firstimageUrl: File(
        'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
    secondImageUrl: File(
        'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
    thirdImageUrl: File(""),
    isVerified: false,
    conversationStarterPrompt: "",
    nicheFilterSelected: false,
    genderPreferences: [],
    ageRangePreference: const RangeValues(18, 40),
  ),
  Profile(
    id: '3',
    birthDate: "",
    name: 'B',
    phoneNumber: '1234567890',
    gender: Gender.nonBinary,
    firstimageUrl: File(
        'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
    secondImageUrl: File(
        'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
    thirdImageUrl: File(""),
    isVerified: false,
    conversationStarterPrompt: "",
    nicheFilterSelected: false,
    genderPreferences: [],
    ageRangePreference: const RangeValues(18, 40),
  ),
  Profile(
    id: '3',
    birthDate: "",
    name: 'C',
    phoneNumber: '1234567890',
    gender: Gender.nonBinary,
    firstimageUrl: File(
        'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
    secondImageUrl: File(
        'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
    thirdImageUrl: File(""),
    isVerified: false,
    conversationStarterPrompt: "",
    nicheFilterSelected: true,
    genderPreferences: [],
    ageRangePreference: const RangeValues(18, 40),
  ),
  Profile(
    id: '3',
    birthDate: "",
    name: 'D',
    phoneNumber: '1234567890',
    gender: Gender.nonBinary,
    firstimageUrl: File(
        'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
    secondImageUrl: File(
        'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
    thirdImageUrl: File(""),
    isVerified: false,
    conversationStarterPrompt: "",
    nicheFilterSelected: true,
    genderPreferences: [],
    ageRangePreference: const RangeValues(18, 40),
  ),
  Profile(
    id: '3',
    birthDate: "",
    name: 'E',
    phoneNumber: '1234567890',
    gender: Gender.nonBinary,
    firstimageUrl: File(
        'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
    secondImageUrl: File(
        'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
    thirdImageUrl: File(""),
    isVerified: false,
    conversationStarterPrompt: "",
    nicheFilterSelected: false,
    genderPreferences: [],
    ageRangePreference: const RangeValues(18, 40),
  ),
  Profile(
    id: '2',
    birthDate: "",
    gender: Gender.man,
    name: 'F',
    phoneNumber: '1234567890',
    firstimageUrl: File(
        'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
    secondImageUrl: File(
        'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
    thirdImageUrl: File(""),
    isVerified: false,
    conversationStarterPrompt: "",
    nicheFilterSelected: true,
    genderPreferences: [],
    ageRangePreference: const RangeValues(18, 40),
  ),
];
