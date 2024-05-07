import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:dating_made_better/utils/general.dart';

class MessageBubble extends StatelessWidget {
  final String stumblerDisplayPic;
  final String message;
  final bool isMe;
  final int messageId;
  final DateTime messageTime;
  final int receiverId;

  @override
  const MessageBubble({
    required this.stumblerDisplayPic,
    required this.message,
    required this.isMe,
    required this.messageId,
    required this.receiverId,
    required this.messageTime,
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? GestureDetector(
                child: messageBubbleContainers(context),
                // Can add deletion/reply functionalities here.
              )
            : GestureDetector(
                child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(
                      marginWidth128(context),
                    ),
                    child: CircleAvatarWidget(
                        marginWidth32(context), stumblerDisplayPic),
                  ),
                  messageBubbleContainers(context),
                ],
              ))
      ],
    );
  }

  Container messageBubbleContainers(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: !isMe ? const Radius.circular(0) : const Radius.circular(12),
          topRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
          bottomLeft:
              !isMe ? const Radius.circular(0) : const Radius.circular(12),
          bottomRight:
              isMe ? const Radius.circular(0) : const Radius.circular(12),
        ),
        color: isMe ? const Color.fromARGB(255, 134, 71, 145) : Colors.black12,
      ),
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 27,
              color: isMe ? whiteColor : textColor,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              textAlign: TextAlign.end,
              beautifyTime(messageTime),
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white : textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
