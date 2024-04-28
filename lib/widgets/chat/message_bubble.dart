import 'package:dating_made_better/constants.dart';
import 'package:flutter/material.dart';
import 'package:dating_made_better/utils/general.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final int messageId;
  final DateTime messageTime;
  final int receiverId;

  @override
  const MessageBubble(
      {required this.message,
      required this.isMe,
      required this.messageId,
      required this.receiverId,
      required this.messageTime,
      required super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: !isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
                bottomRight:
                    isMe ? const Radius.circular(12) : const Radius.circular(0),
              ),
              color: isMe ? Colors.purple : Colors.black12,
            ),
            width: 140,
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
                    fontSize: 20,
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
          ),
        ),
      ],
    );
  }
}
