import 'package:dating_made_better/constants.dart';

class ChatThread {
  final String threadId;
  final int userId;
  final int chatterId;
  final int lastMsgId;
  final String name;
  final String displayPic;
  final String message;
  final DateTime createdAt;

  ChatThread(
      {required this.threadId,
      required this.userId,
      required this.chatterId,
      required this.lastMsgId,
      required this.name,
      required this.displayPic,
      required this.message,
      required this.createdAt});

  static fromJson(dynamic thread) {
    // {thread_id: 3f8e13a7-38d4-4ac2-9807-7f8b8d9f495e, user_id: 1600, chatter_id: 1604, last_msg_id: 20974, name: Sarthak6, display_pic: null, message: Hi 100, createdAt: 2023-09-21T17:50:02.705Z}
    return ChatThread(
      threadId: thread["thread_id"],
      userId: thread["user_id"],
      chatterId: thread["chatter_id"],
      lastMsgId: thread["last_msg_id"],
      name: thread["name"],
      displayPic: thread["display_pic"] ?? defaultBackupImage,
      message: thread["message"] ?? "",
      createdAt: thread["createdAt"]
          ? DateTime.parse(thread["createdAt"])
          : DateTime.now(),
    );
  }
}

class ChatMessage {
  final int id;
  final String threadId;
  final int senderId;
  final int receiverId;
  final int? replyMessageId;
  final String message;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatMessage(
      {required this.id,
      required this.threadId,
      required this.senderId,
      required this.receiverId,
      this.replyMessageId,
      required this.message,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  static fromJson(dynamic message) {
    return ChatMessage(
      id: message["id"],
      threadId: message["thread_id"],
      senderId: message["sender_id"],
      receiverId: message["receiver_id"],
      replyMessageId: message["reply_message_id"],
      message: message["message"],
      status: message["status"],
      createdAt: DateTime.parse(message["createdAt"]),
      updatedAt: DateTime.parse(message["updatedAt"]),
    );
  }
}
