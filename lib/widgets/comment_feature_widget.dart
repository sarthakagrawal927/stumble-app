import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/text_styles.dart';
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
                top: marginWidth64(context),
                right: marginWidth24(context),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.transparent.withOpacity(0.8),
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: marginWidth12(context),
                              right: marginWidth12(context),
                              bottom: 0.0),
                          child: Badge(
                            alignment: Alignment.centerLeft,
                            isLabelVisible: false,
                            backgroundColor: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(marginWidth32(context)),
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: marginWidth24(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 16,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              SizedBox(
                                height: marginHeight4(context),
                                width:
                                    MediaQuery.of(context).size.width * 0.825,
                                child: !isImage
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: marginWidth32(context),
                                              vertical: marginHeight128(context),
                                            ),
                                            child: Text(
                                                textAlign: TextAlign.left,
                                                "Talk to me about",
                                                style: AppTextStyles
                                                    .descriptionText(context)),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: marginWidth32(context),
                                              vertical: marginHeight128(context),
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
                              Padding(
                                padding: EdgeInsets.all(marginWidth12(context)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      onSwipe(
                                          ActivityType.like, commentOnWidget);
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
              icon: const Icon(
                Icons.favorite_outline_rounded,
                color: AppColors.primaryColor,
              ),
              iconSize: marginWidth12(context),
            ))
      ],
    );
  }
}
