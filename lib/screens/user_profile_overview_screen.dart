import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/screens/user_profile_completion_screen.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/bottom_app_bar.dart';
import 'package:dating_made_better/widgets/common/buttons.dart';
import 'package:dating_made_better/widgets/dropdown_options_constants.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:dating_made_better/widgets/top_app_bar_constants.dart';
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
    int photoVerificationStatus =
        Provider.of<Profile>(context).getPhotoVerificationStatus;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: TopAppBar(
        showLeading: false,
        showActions: true,
        dropDownItems: profileScreensDropdownOptions,
        heading: 'Stumble',
        screen: Screen.userProfileOverviewScreen,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: marginWidth16(context),
              vertical: marginHeight32(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: marginHeight64(context),
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
                      backgroundImage: CachedNetworkImageProvider(
                        photos.isNotEmpty ? photos[0].path : defaultBackupImage,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: marginHeight64(context),
                ),
                Text(
                  'Profile completion: $profileCompletionPercentage%',
                  style: AppTextStyles.descriptionText(context),
                ),
                SizedBox(
                  height: marginHeight64(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('$name, $age',
                        style: AppTextStyles.chatNameText(context)),
                    Container(
                      color: Colors.transparent,
                      child: Icon(
                        color: photoVerificationStatus ==
                                photoVerificationStatusValue[
                                    PhotoVerificationStatus.verified]
                            ? Colors.blueAccent
                            : Colors.black45,
                        photoVerificationStatus ==
                                photoVerificationStatusValue[
                                    PhotoVerificationStatus.verified]
                            ? Icons.verified_rounded
                            : Icons.verified_outlined,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: marginHeight64(context),
                ),
                SecondaryButton(
                  text: "Edit Profile",
                  onPressed: () {
                    Navigator.pushNamed(
                        context, UserProfileCompletionScreen.routeName);
                  },
                ),
                SizedBox(
                  height: marginHeight64(context),
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
