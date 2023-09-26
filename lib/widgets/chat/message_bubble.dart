import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final int messageId;
  final int receiverId;

  @override
  const MessageBubble(
      {required this.message,
      required this.isMe,
      required this.messageId,
      required this.receiverId,
      required super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: () async {
            Provider.of<Profile>(context, listen: false)
                .deleteMessageFromMessagesList(messageId);
            await Provider.of<Profile>(context, listen: false)
                .deleteMessageAPI(messageId, receiverId);
          },
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
              color: isMe
                  ? const Color.fromRGBO(28, 26, 26, 1)
                  : const Color.fromRGBO(48, 48, 48, 1),
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
            child: Text(
              message,
              style: TextStyle(
                fontSize: 20,
                color: isMe ? Colors.white : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
