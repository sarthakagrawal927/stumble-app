import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/utils/general.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final int messageId;
  final DateTime messageTime;
  final int receiverId;

  @override
  const MessageBubble({
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
                child: messageBubbleContainers(context),
              )
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
        color: isMe ? AppColors.secondaryColor : Colors.grey[200],
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
              fontSize: MediaQuery.of(context).size.width / 22,
              fontWeight: FontWeight.w500,
              color: isMe ? AppColors.backgroundColor : AppColors.primaryColor,
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
