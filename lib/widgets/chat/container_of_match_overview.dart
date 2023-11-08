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
  @override
  Widget build(BuildContext context) {
    Widget getStack(List<Widget> children) {
      return Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.65, // You can set a specific width here
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(thread: widget.threadDetails)));
      },
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 24,
          right: MediaQuery.of(context).size.width / 32,
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
                getStack([
                  Text(
                    widget.threadDetails.name,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  // add a red dot to show unread
                  Text(
                    widget.threadDetails.hasUnread ? "●" : "",
                    style:
                        const TextStyle(fontSize: 25, color: Colors.redAccent),
                  ),
                ]),
                getStack([
                  Flexible(
                    child: Text(
                      widget.threadDetails.message,
                      style: const TextStyle(
                          fontSize: 12.5, color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(beautifyTime(widget.threadDetails.lastMsgTime),
                      style: const TextStyle(
                          fontSize: 12.5, color: Colors.white30)),
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
