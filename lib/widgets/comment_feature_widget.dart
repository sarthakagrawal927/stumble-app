import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';

class CommentFeatureWidget extends StatelessWidget {
  const CommentFeatureWidget(this.widget, this.profile, {super.key});
  final Widget widget;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    String commentOnWidget = "";
    return Stack(
      children: [
        widget,
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.white38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    elevation: 16,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        const Center(
                          child: Text(
                            'Leave a comment!',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 12),
                          child: TextField(
                            maxLines: 3,
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        IconButton(
                          iconSize: 60,
                          icon: const Icon(Icons.arrow_circle_right_sharp),
                          onPressed: () {
                            Provider.of<Profile>(context, listen: false)
                                .setLikedListOfProfiles = profile;
                            Provider.of<Profile>(context, listen: false)
                                .removeLikedProfilesWhenNicheButtonIsClicked(
                                    profile,
                                    widget,
                                    commentOnWidget,
                                    "",
                                    SwipeType.comment);

                            Navigator.of(context, rootNavigator: true).pop("");
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.comment_rounded),
            iconSize: MediaQuery.of(context).size.width / 12,
            color: const Color.fromRGBO(231, 10, 95, 1),
          ),
        )
      ],
    );
  }
}
