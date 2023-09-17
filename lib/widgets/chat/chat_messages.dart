import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final List<ChatMessage> listOfChatMessages;

  const ChatMessages(this.listOfChatMessages, {super.key});

  @override
  Widget build(BuildContext context) {
    int selfUserId = AppConstants.user["id"];

    return ListView.builder(
      reverse: false,
      itemBuilder: ((context, index) => MessageBubble(
            message: listOfChatMessages[index].message,
            isMe: listOfChatMessages[index].senderId == selfUserId,
            messageId: listOfChatMessages[index].id,
            receiverId: listOfChatMessages[index].receiverId,
            key: ValueKey(
              listOfChatMessages[index].id,
            ),
          )),
      itemCount: listOfChatMessages.length,
    );
  }
}
