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

  static fromJSON(dynamic thread) {
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
