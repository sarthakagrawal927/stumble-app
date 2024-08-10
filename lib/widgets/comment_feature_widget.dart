import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/widgets/common/dialog_widget.dart';
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
            child: Padding(
              padding: EdgeInsets.only(
                top: marginWidth64(context),
                right: marginWidth64(context),
              ),
              child: IconButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.primaryColor,
                  ),
                ),
                onPressed: () {
                  dialogWidget(
                      context: context,
                      submitLabel: "Like",
                      onSubmit: () async {
                        onSwipe(ActivityType.like, commentOnWidget);
                        Navigator.of(context, rootNavigator: true).pop("");
                      },
                      childWidget: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            child: widget,
                          ),
                          TextField(
                            maxLines: 2,
                            minLines: 1,
                            cursorColor: Colors.black,
                            autocorrect: true,
                            autofocus: true,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: "Leave a compliment!",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            textInputAction: TextInputAction.newline,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            maxLength: 75,
                            onChanged: (value) {
                              commentOnWidget = value;
                            },
                          )
                        ],
                      ),
                      title: "Like $name!");
                },
                icon: const Icon(
                  Icons.favorite_rounded,
                  applyTextScaling: true,
                  color: AppColors.backgroundColor,
                  semanticLabel: "Like the profile",
                ),
                iconSize: MediaQuery.of(context).size.width / 13,
              ),
            ))
      ],
    );
  }
}
