import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  final String id;
  final String name;
  final double age;
  List<String> imageUrls;
  bool isVerified;
  final List<String> conversationStarterList;

  Profile({
    required this.id,
    required this.name,
    required this.age,
    this.isVerified = false,
    required this.imageUrls,
    required this.conversationStarterList,
  });

  final List<String> _images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmEQyguqPeNS0rFBoHIJ_JWFzAzN14Hk1R3e2xEEkr2g&s',
    'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=',
    'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'
  ];

  // // Function to get the list of images.
  // List<String> get images {
  //   return [..._images];
  // }

  // // // Function to add an image to the profile.
  // void addImage(String imageUrl) {
  //   _images.add(imageUrl);
  //   notifyListeners();
  // }

  // // Function to change an image in the profile.
  // void updateImage(String id, String imageUrl) {
  //   final imageIndex = _images.indexWhere((image) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }
}
