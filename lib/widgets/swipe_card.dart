import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/widgets/comment_feature_widget.dart';
import 'package:dating_made_better/widgets/common/small_profile_badge.dart';
import 'package:flutter/material.dart';

import '../providers/profile.dart';

void doNothing(ActivityType act, [String? compliment]) {}

class SwipeCard extends StatelessWidget {
  const SwipeCard(
      {super.key,
      required this.profile,
      this.onSwipe = doNothing,
      this.isModalMode = false});
  final Profile profile;
  final bool isModalMode;
  final Function(ActivityType activity, [String? compliment]) onSwipe;

  Widget getCommentFeatureWidget(
      Widget childComponent, bool isImage, String text) {
    if (isModalMode) return childComponent;
    return CommentFeatureWidget(
      childComponent,
      onSwipe,
      isImage,
      text,
      profile.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(
        left: marginWidth32(context),
        right: marginWidth32(context),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *
                (isModalMode ? 0.01 : 0.02),
          ),
          getCommentFeatureWidget(
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  (isModalMode ? 0.3 : 0.45),
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: imageBoxWidget(context, 0),
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(marginWidth32(context)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              userInformationOnImage(context, profile.getName),
                              userInformationOnImage(
                                  context, profile.getAge.toString(), false),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
            true,
            "",
          ),
          // add gender

          Padding(
            padding: EdgeInsets.only(
              left: marginWidth32(context),
            ),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: marginHeight64(context)),
                child: Row(children: [
                  SmallProfileBadge(text: profile.gender.name),
                  SizedBox(width: marginWidth64(context)),
                  // SmallProfileBadge(text: "${profile.getAge} years old"),
                  SizedBox(width: marginWidth64(context)),
                  // verified text
                  if (profile.photoVerificationStatus ==
                      photoVerificationStatusValue[
                          PhotoVerificationStatus.verified])
                    const SmallProfileBadge(
                      text: "Verified",
                      icon: Icons.verified,
                    ),
                ]),
              ),
              getCommentFeatureWidget(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: marginWidth32(context),
                      ),
                      child: Text(
                        'Talk to me about',
                        style: AppTextStyles.descriptionText(context),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadiusValue),
                          bottomRight: Radius.circular(borderRadiusValue),
                        ),
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 6,
                      padding: EdgeInsets.only(
                        top: marginWidth32(context),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          style: AppTextStyles.regularText(context),
                          profile.conversationStarter,
                        ),
                      ),
                    ),
                  ],
                ),
                false,
                profile.conversationStarter,
              ),
            ]),
          ),
          Container(
            height: marginHeight16(context),
            color: backgroundColor,
          ),
          if (profile.getPhotos.length > 1) photoWidget(context, 1),
          if (profile.getPhotos.length > 2) photoWidget(context, 2),
        ],
      ),
    );
  }

  Text userInformationOnImage(BuildContext context, String textToDisplay,
      [bool addComma = true]) {
    return Text(
      "$textToDisplay${addComma ? ',' : ''} ",
      style: AppTextStyles.secondaryHeading(context),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget photoWidget(BuildContext context, int index) {
    return Column(
      children: [
        getCommentFeatureWidget(
          Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
                alignment: Alignment.bottomLeft,
                decoration: imageBoxWidget(context, index)),
          ),
          true,
          "",
        ),
        Container(
          height: marginHeight16(context),
          color: backgroundColor,
        ),
      ],
    );
  }

  BoxDecoration imageBoxWidget(BuildContext context, int index) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(borderRadiusValue),
      ),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(profile.photos.isNotEmpty
            ? profile.photos[index].path
            : defaultBackupImage),
      ),
    );
  }
}
