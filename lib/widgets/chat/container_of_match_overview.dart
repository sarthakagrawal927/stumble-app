import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile.dart';
import '../../screens/individual_chats_screen.dart';
import '../circle_avatar.dart';

class ContainerOfMatchOverview extends StatefulWidget {
  const ContainerOfMatchOverview(this.threadDetails, {super.key});

  final dynamic threadDetails;

  @override
  State<ContainerOfMatchOverview> createState() =>
      _ContainerOfMatchOverviewState();
}

class _ContainerOfMatchOverviewState extends State<ContainerOfMatchOverview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed(ChatScreen.routeName);
        await Provider.of<Profile>(context, listen: false)
            .getMessagesAPI(widget.threadDetails['thread_id']);
      },
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 32,
          left: MediaQuery.of(context).size.width / 24,
          right: MediaQuery.of(context).size.width / 32,
        ),
        child: Row(
          children: [
            // CircleAvatarWidget(threadDetails['display_pic']),
            CircleAvatarWidget(
                'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
            SizedBox(
              width: MediaQuery.of(context).size.width / 24,
            ),
            Column(
              children: [
                Text(
                  widget.threadDetails['name'],
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
