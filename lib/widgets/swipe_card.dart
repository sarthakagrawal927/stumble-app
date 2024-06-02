import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/widgets/comment_feature_widget.dart';
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
              child: Padding(
                padding: EdgeInsets.only(
                  left: marginWidth32(context),
                  right: marginWidth32(context),
                ),
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
                                userInformationOnImage(
                                    context, profile.getName),
                                userInformationOnImage(
                                    context, profile.getAge.toString(), false),
                                if (profile.photoVerified)
                                  verificationIconWidget(
                                    context,
                                    Icons.verified_sharp,
                                    Colors.blue,
                                  )
                              ]),
                          profile.getBadgeLabel.isNotEmpty
                              ? Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Badge(
                                    isLabelVisible: false,
                                    child: Text(
                                      profile.getBadgeLabel,
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontSize:
                                            marginWidth32(context),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            true,
            "",
          ),
          getCommentFeatureWidget(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusValue),
                      topRight: Radius.circular(borderRadiusValue),
                    ),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: marginWidth32(context),
                    right: marginWidth32(context),
                    top: marginWidth128(context),
                  ),
                  padding: EdgeInsets.only(
                    top: marginWidth32(context),
                    left: marginWidth32(context),
                    right: marginWidth32(context),
                  ),
                  child: Text(
                    'Talk to me about',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: marginHeight64(context),
                    ),
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
                  margin: EdgeInsets.only(
                    left: marginWidth32(context),
                    right: marginWidth32(context),
                  ),
                  height: MediaQuery.of(context).size.height / 6,
                  padding: EdgeInsets.only(
                    top: marginWidth32(context),
                    left: marginWidth32(context),
                    right: marginWidth32(context),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 48,
                        color: textColor,
                      ),
                      profile.conversationStarter,
                    ),
                  ),
                ),
              ],
            ),
            false,
            profile.conversationStarter,
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

  Icon verificationIconWidget(
      BuildContext context, IconData icon, Color color) {
    return Icon(
      icon,
      color: color,
      size: marginWidth16(context),
    );
  }

  Container platonicIconWidget(BuildContext context, IconData icon) {
    return Container(
      margin: EdgeInsets.only(
        top: marginWidth64(context),
        left: marginWidth64(context),
      ),
      alignment: Alignment.topLeft,
      child: Icon(
        icon,
        color: const Color.fromARGB(255, 223, 111, 103),
        size: marginWidth8(context),
      ),
    );
  }

  Text userInformationOnImage(BuildContext context, String textToDisplay,
      [bool addComma = true]) {
    return Text(
      "$textToDisplay ${addComma ? ',' : ''} ",
      style: TextStyle(
        backgroundColor: Colors.transparent,
        color: whiteColor,
        fontSize: marginWidth16(context),
        fontWeight: FontWeight.w900,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget photoWidget(BuildContext context, int index) {
    return Column(
      children: [
        getCommentFeatureWidget(
          Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height * 0.3,
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
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(borderRadiusValue),
        topRight: Radius.circular(borderRadiusValue),
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
