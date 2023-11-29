import 'package:flutter/material.dart';

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

  String getTimeOfMessage(DateTime messageTime) {
    String hoursValue = messageTime.hour.toString().padLeft(2, '0');
    String minutesValue = messageTime.minute.toString().padLeft(2, '0');
    return "$hoursValue:$minutesValue";
  }

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
              color:
                  isMe ? Colors.black26 : const Color.fromRGBO(48, 48, 48, 1),
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
                    color: isMe ? Colors.white : Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    textAlign: TextAlign.end,
                    getTimeOfMessage(messageTime),
                    style: TextStyle(
                      fontSize: 10,
                      color: isMe ? Colors.white : Colors.white,
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
