class ChatThread {
  final String threadId;
  final int userId;
  final int chatterId;
  final int lastMsgId;
  final String name;
  final String? displayPic;
  final String message;
  final DateTime createdAt;

  ChatThread(
      {required this.threadId,
      required this.userId,
      required this.chatterId,
      required this.lastMsgId,
      required this.name,
      this.displayPic,
      required this.message,
      required this.createdAt});

  static fromJson(dynamic thread) {
    return ChatThread(
      threadId: thread["thread_id"],
      userId: thread["user_id"],
      chatterId: thread["chatter_id"],
      lastMsgId: thread["last_msg_id"],
      name: thread["name"],
      displayPic: thread["display_pic"],
      message: thread["message"],
      createdAt: DateTime.parse(thread["createdAt"]),
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
