import 'package:dating_made_better/models/chat.dart';
import 'package:flutter/material.dart';

class IndividualThreadData {
  int count;
  String lastMessage; // can think of using a list of messages in future
  bool isTyping;
  IndividualThreadData(
      {this.count = 0, this.lastMessage = "", this.isTyping = false});
}

class RealtimeProvider with ChangeNotifier {
  int newMessageCount;

  Map<String, IndividualThreadData> threadsData = {};
  List<ChatMessage> activeThreadMessages = [];
  String activeThreadId = "";
  RealtimeProvider({this.newMessageCount = 0});

  // can be used for threads page and everywhere else
  void handleNewChatMessage(data) {
    threadsData.update(data['sender_id'], (value) {
      value.count++;
      value.lastMessage = (data['message']);
      return value;
    }, ifAbsent: () {
      return IndividualThreadData(count: 1, lastMessage: data['message']);
    });
    newMessageCount++;
    if (activeThreadId == data['sender_id']) {
      activeThreadMessages.add(
        // TODO: Improve this, also consider backend will start sending threadIds
        ChatMessage(
            id: data['id'],
            message: data['message'],
            threadId: data['thread_id'],
            senderId: data['sender_id'],
            status: 2,
            receiverId: data['receiver_id'],
            updatedAt: data['updated_at'],
            createdAt: data['created_at']),
      );
    }
    notifyListeners();
  }

  void openChatThread(String threadId) {
    newMessageCount -= threadsData[threadId]!.count;
    threadsData.update(threadId, (value) {
      value.count = 0;
      return value;
    });
    notifyListeners();
  }

  void initializeActiveThreadMessages(
      List<ChatMessage> messages, String threadId) {
    activeThreadMessages = messages;
    activeThreadId = threadId;
    notifyListeners();
  }

  void addUserMessageToActiveThread(ChatMessage message) {
    activeThreadMessages.add(message);
    notifyListeners();
  }
}
