import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';

class CommentFeatureWidget extends StatelessWidget {
  const CommentFeatureWidget(this.widget, this.onSwipe, this.isImage,
      {super.key});
  final Widget widget;
  final Function onSwipe;
  final bool isImage;

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
                barrierColor: Colors.transparent.withOpacity(0.925),
                builder: (context) {
                  return Dialog(
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
                              ? ListView(
                                  shrinkWrap: true,
                                  children: [widget],
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
                              iconSize: MediaQuery.of(context).size.width / 10,
                              icon: const Icon(
                                Icons.check,
                              ),
                              onPressed: () {
                                onSwipe(commentOnWidget);
                                Navigator.of(context, rootNavigator: true)
                                    .pop("");
                              },
                            ),
                            IconButton(
                              iconSize: MediaQuery.of(context).size.width / 10,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop("");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.comment_rounded),
            iconSize: MediaQuery.of(context).size.width / 12,
            color: headingColor,
          ),
        )
      ],
    );
  }
}
