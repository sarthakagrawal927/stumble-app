import 'package:dating_made_better/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  // Future<List<dynamic>> getMessages() async {
  //   return await Provider.of<Profile>(context, listen: false).getMessagesAPI();
  // }

  @override
  Widget build(BuildContext context) {
    int currentUser = Provider.of<Profile>(context, listen: false).currentUser;
    List<dynamic> messagesList = Provider.of<Profile>(context).getMessagesList;
    return ListView.builder(
      reverse: false,
      itemBuilder: ((context, index) => MessageBubble(
            messagesList[index]['message'],
            messagesList[index]['sender_id'] == currentUser,
            messagesList[index]['id'],
            messagesList[index]['receiver_id'],
            key: ValueKey(
              messagesList[index]['id'],
            ),
          )),
      itemCount: messagesList.length,
    );
  }
}
