import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChatMessages extends StatelessWidget {
  final List<ChatMessage> listOfChatMessages;
  final String stumblerDisplayPic;

  const ChatMessages(this.listOfChatMessages, this.stumblerDisplayPic,
      {super.key});

  @override
  Widget build(BuildContext context) {
    int selfUserId = AppConstants.user["id"];

    ScrollController scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    return ListView.builder(
      reverse: false,
      controller: scrollController,
      itemBuilder: ((context, index) => MessageBubble(
            message: listOfChatMessages[index].message,
            isMe: listOfChatMessages[index].senderId == selfUserId,
            messageId: listOfChatMessages[index].id,
            receiverId: listOfChatMessages[index].receiverId,
            key: ValueKey(
              listOfChatMessages[index].id,
            ),
            messageTime: listOfChatMessages[index].createdAt,
          )),
      itemCount: listOfChatMessages.length,
    );
  }
}
