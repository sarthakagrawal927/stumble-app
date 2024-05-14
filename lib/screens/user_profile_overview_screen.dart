import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_made_better/screens/user_profile_completion_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/bottom_app_bar.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:dating_made_better/widgets/top_app_bar_with_screens_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/profile.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = "/user-profile-screen";
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int profileCompletionPercentage =
        Provider.of<Profile>(context).getPercentageOfProfileCompleted.toInt();
    String name = Provider.of<Profile>(context).getName;
    int age = Provider.of<Profile>(context).getAge;
    List<File> photos = Provider.of<Profile>(context).getPhotos;
    bool isProfileVerified =
        Provider.of<Profile>(context).getPhotoVerificationStatus;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: TopAppBarWithScreensOption(
        routeName: "",
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: marginWidth16(context),
              vertical: marginHeight32(context),
            ),
            color: whiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onDoubleTap: () => DoNothingAction(),
                    onTap: () async {
                      getUserApi().then((value) => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SwipeCard(
                                profile: value!,
                                isModalMode: true,
                              );
                            },
                          ));
                    },
                    child: CircleAvatar(
                      maxRadius: 75,
                      minRadius: 75,
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(
                        photos.isNotEmpty ? photos[0].path : defaultBackupImage,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.transparent,
                  child: Text(
                    'Profile completion: $profileCompletionPercentage%',
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Text(
                        '$age ',
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Icon(
                        color: isProfileVerified
                            ? Colors.blueAccent
                            : Colors.black45,
                        isProfileVerified
                            ? Icons.verified_rounded
                            : Icons.verified_outlined,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  child: const Text(
                    'Edit Profile?',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, UserProfileCompletionScreen.routeName);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
          currentScreen: BottomBarScreens.userProfileOverviewScreen),
    );
  }
}
