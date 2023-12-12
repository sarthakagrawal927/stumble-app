import 'package:dating_made_better/constants.dart';

class ChatThread {
  final String threadId;
  final int userId;
  final int chatterId;
  final int lastMsgId;
  final String name;
  final String displayPic;
  final String message;
  final bool hasUserUnread;
  final bool yourMove;
  final DateTime? lastMsgTime;

  ChatThread(
      {required this.threadId,
      required this.userId,
      required this.chatterId,
      required this.lastMsgId,
      required this.name,
      required this.displayPic,
      required this.message,
      required this.hasUserUnread,
      required this.yourMove,
      this.lastMsgTime});

  static fromJson(dynamic thread) {
    // {"thread_id":"5a3a95b2-b468-47f6-9548-3f5ef77805e2","user_id":1,"chatter_id":2,"last_msg_id":1,"name":"Sarthak1","display_pic":null,"message":"Hi 0","createdAt":"2023-09-19T15:08:49.550Z"}
    return ChatThread(
      threadId: thread["thread_id"],
      userId: thread["user_id"] ?? 0,
      chatterId: thread["chatter_id"] ?? 0,
      lastMsgId: thread["last_msg_id"] ?? 0,
      name: thread["name"] ?? " ",
      displayPic: thread["display_pic"] ?? defaultBackupImage,
      message: thread["message"] ?? "",
      lastMsgTime: thread["last_msg_time"] != null
          ? DateTime.parse(thread["last_msg_time"])
          : null,
      hasUserUnread: thread["has_user_unread"] == 1 ? true : false,
      yourMove: thread["your_move"] == 1 ? true : false,
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

  ChatMessage({
    required this.id,
    required this.threadId,
    required this.senderId,
    required this.receiverId,
    this.replyMessageId,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  static fromJson(dynamic message) {
    return ChatMessage(
      id: message["id"],
      threadId: message["thread_id"],
      senderId: message["sender_id"],
      receiverId: message["receiver_id"],
      replyMessageId: message["reply_message_id"] ?? 0,
      message: message["message"],
      status: message["status"],
      createdAt: DateTime.parse(message["createdAt"]),
      updatedAt: DateTime.parse(message["updatedAt"]),
    );
  }
}
