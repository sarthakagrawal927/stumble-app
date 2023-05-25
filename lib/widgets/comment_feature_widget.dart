import 'package:flutter/material.dart';

class CommentFeatureWidget extends StatelessWidget {
  const CommentFeatureWidget(this.widget, {super.key});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor: Colors.white,
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
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 12),
                          child: const TextField(
                            cursorColor: Colors.white70,
                            autocorrect: true,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                            maxLength: 250,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_right_sharp),
                          onPressed: () {},
                        )
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
