import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_made_better/constants.dart';
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
      width: MediaQuery.of(context).size.width * (isModalMode ? 0.85 : 0.94),
      child: ListView(
        shrinkWrap: true,
        children: [
          getCommentFeatureWidget(
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  (isModalMode ? 0.4 : 0.6),
              width: double.infinity,
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: imageBoxWidget(context, 0),
                child: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32,
                      right: MediaQuery.of(context).size.width / 32,
                      bottom: MediaQuery.of(context).size.width / 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              userInformationOnImage(context, profile.getName),
                              userInformationOnImage(
                                  context, profile.getAge.toString(), false),
                              profile.photoVerified
                                  ? verificationIconWidget(context,
                                      Icons.verified_sharp, Colors.blue)
                                  : verificationIconWidget(context,
                                      Icons.verified_outlined, Colors.white)
                            ]),
                        profile.getBadgeLabel.isNotEmpty
                            ? Align(
                                alignment: Alignment.bottomLeft,
                                child: Badge(
                                  isLabelVisible: false,
                                  child: Text(
                                    profile.getBadgeLabel,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              32,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )),
              ),
            ),
            true,
            "",
          ),
          Container(
            height: MediaQuery.of(context).size.height / 24,
          ),
          getCommentFeatureWidget(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 16,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32),
                  child: Text(
                    'Talk to me about',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 32,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.235,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 32,
                    right: MediaQuery.of(context).size.width / 32,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 48,
                        color: Colors.white70,
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
            height: MediaQuery.of(context).size.height / 16,
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
      size: MediaQuery.of(context).size.width / 16,
    );
  }

  Container platonicIconWidget(BuildContext context, IconData icon) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 64,
        left: MediaQuery.of(context).size.width / 64,
      ),
      alignment: Alignment.topLeft,
      child: Icon(
        icon,
        color: const Color.fromARGB(255, 223, 111, 103),
        size: MediaQuery.of(context).size.width / 8,
      ),
    );
  }

  Text userInformationOnImage(BuildContext context, String textToDisplay,
      [bool addComma = true]) {
    return Text(
      "$textToDisplay ${addComma ? ',' : ''} ",
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.width / 16,
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
          height: MediaQuery.of(context).size.height / 16,
          color: backgroundColor,
        ),
      ],
    );
  }

  BoxDecoration imageBoxWidget(BuildContext context, int index) {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(profile.photos.isNotEmpty
            ? profile.photos[index].path
            : defaultBackupImage),
      ),
    );
  }
}
