import 'package:dating_made_better/models/chat.dart';
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
  String messageToDisplay(String message) {
    if (message.length < 40) return message;
    return "${message.substring(0, 37)}...";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context)
            .pushNamed(ChatScreen.routeName, arguments: widget.threadDetails);
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
                Text(
                  widget.threadDetails.name,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                Text(
                  messageToDisplay(widget.threadDetails.message),
                  style: const TextStyle(fontSize: 12.5, color: Colors.white54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
