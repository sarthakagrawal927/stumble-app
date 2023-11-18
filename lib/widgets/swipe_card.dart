import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/widgets/comment_feature_widget.dart';
import 'package:flutter/material.dart';

import '../providers/profile.dart';

class SwipeCard extends StatelessWidget {
  const SwipeCard({super.key, required this.profile, required this.onSwipe});
  final Profile profile;
  final Function onSwipe;

  Widget getCommentFeatureWidget(Widget childComponent) {
    return CommentFeatureWidget(childComponent, onSwipe);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        shrinkWrap: true,
        children: [
          getCommentFeatureWidget(
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.395,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${profile.name}, ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 16,
                          fontWeight: FontWeight.w900,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${profile.getAge} ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      profile.photoVerified
                          ? Icon(
                              Icons.verified_sharp,
                              color: Colors.blue,
                              size: MediaQuery.of(context).size.width / 16,
                            )
                          : Icon(
                              Icons.verified_outlined,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width / 16,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height / 24,
          ),
          getCommentFeatureWidget(
            Container(
              color: backgroundColor,
              child: Column(
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
                    height: MediaQuery.of(context).size.height / 32,
                    color: backgroundColor,
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
            ),
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
      color: backgroundColor,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(profile.photos.isNotEmpty
            ? profile.photos[index].path
            : defaultBackupImage),
      ),
    );
  }
}
