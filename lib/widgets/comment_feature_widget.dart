import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';

class CommentFeatureWidget extends StatelessWidget {
  const CommentFeatureWidget(
      this.widget, this.onSwipe, this.isImage, this.textOnProfile, this.name,
      {super.key});
  final Widget widget;
  final Function(ActivityType activity, [String? compliment]) onSwipe;
  final bool isImage;
  final String textOnProfile;
  final String name;

  @override
  Widget build(BuildContext context) {
    String commentOnWidget = "";
    return Stack(
      children: [
        widget,
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            padding: EdgeInsets.only(
              top: isImage
                  ? MediaQuery.of(context).size.width / 24
                  : MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 24,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.transparent.withOpacity(0.925),
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 12,
                            right: MediaQuery.of(context).size.width / 12),
                        child: Badge(
                          alignment: Alignment.centerLeft,
                          isLabelVisible: false,
                          backgroundColor: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 32),
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(200),
                              ),
                            ),
                            child: Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize:
                                    MediaQuery.of(context).size.width / 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        elevation: 16,
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width * 0.825,
                              child: !isImage
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  64),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                32,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                64,
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.left,
                                            "Talk to me about",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  32,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                32,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                64,
                                          ),
                                          child: Text(
                                            textOnProfile,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : widget,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 64,
                              color: Colors.transparent.withOpacity(0.925),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 12),
                              child: TextField(
                                maxLines: 2,
                                minLines: 1,
                                cursorColor: Colors.black,
                                autocorrect: true,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                maxLength: 75,
                                onChanged: (value) {
                                  commentOnWidget = value;
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  iconSize:
                                      MediaQuery.of(context).size.width / 10,
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop("");
                                  },
                                ),
                                IconButton(
                                  iconSize:
                                      MediaQuery.of(context).size.width / 10,
                                  icon: const Icon(
                                    Icons.check,
                                  ),
                                  onPressed: () {
                                    onSwipe(ActivityType.like, commentOnWidget);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop("");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.comment_rounded,
              color: isImage
                  ? commentIconColorForPhotos
                  : commentIconColorForOtherPrompts,
            ),
            iconSize: MediaQuery.of(context).size.width / 12,
            color: headingColor,
          ),
        )
      ],
    );
  }
}
