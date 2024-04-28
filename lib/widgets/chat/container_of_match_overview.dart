import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/utils/general.dart';
import 'package:flutter/material.dart';

import '../../screens/individual_chats_screen.dart';
import '../circle_avatar.dart';

class ContainerOfMatchOverview extends StatefulWidget {
  const ContainerOfMatchOverview(this.threadDetails, {super.key});

  final ChatThread threadDetails;

  @override
  State<ContainerOfMatchOverview> createState() =>
      _ContainerOfMatchOverviewState();
}

class _ContainerOfMatchOverviewState extends State<ContainerOfMatchOverview> {
  Widget getStack(List<Widget> children) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width *
            0.68, // You can set a specific width here
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasConversationStarted = widget.threadDetails.lastMsgTime != null;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(thread: widget.threadDetails)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          color: widgetColor,
        ),
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width / 32,
        ),
        child: Row(
          children: [
            // CircleAvatarWidget(threadDetails['display_pic']),
            CircleAvatarWidget(MediaQuery.of(context).size.height / 32,
                widget.threadDetails.displayPic),
            SizedBox(
              width: MediaQuery.of(context).size.width / 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStack(
                  [
                    Flexible(
                      child: Text(
                        widget.threadDetails.name,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // add a red dot to show unread
                    hasConversationStarted && widget.threadDetails.hasUserUnread
                        ? const Text(
                            "●",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.greenAccent,
                            ),
                          )
                        : hasConversationStarted &&
                                widget.threadDetails.yourMove
                            ? Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Badge(
                                  isLabelVisible: false,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          512,
                                      right: MediaQuery.of(context).size.width /
                                          128,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(200),
                                      ),
                                    ),
                                    child: const Text(
                                      "Your Move!",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                  ],
                ),
                getStack([
                  Flexible(
                    child: Text(
                      hasConversationStarted
                          ? widget.threadDetails.message
                          : "Conversation not started yet",
                      style: TextStyle(
                        fontSize: 12.5,
                        color: textColor,
                        fontStyle: hasConversationStarted
                            ? FontStyle.normal
                            : FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,

                      // italics if hasConversationStarted
                    ),
                  ),
                  Text(
                      hasConversationStarted
                          ? beautifyTime(
                              widget.threadDetails.lastMsgTime as DateTime)
                          : "",
                      style: const TextStyle(fontSize: 12.5, color: textColor)),
                ]),
              ],
            ),
            // add time at end
          ],
        ),
      ),
    );
  }
}
