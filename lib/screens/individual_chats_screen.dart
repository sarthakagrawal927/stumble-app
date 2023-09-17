import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_app_bar.dart';

Future<List<ChatMessage>> _getChatMessages(String threadId) async {
  var threads = await getChatMessages(threadId);
  debugPrint(threads.length.toString());
  return threads.map<ChatMessage>((e) => ChatMessage.fromJson(e)).toList();
}

Future<ChatMessage> _addNewMessage(
    String threadId, String message, int receiverId) async {
  return await addChatMessage(threadId, message, receiverId);
}

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> listOfChatMessages = [];
  late ChatThread thread;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    thread = (ModalRoute.of(context)?.settings.arguments) as ChatThread;

    _getChatMessages(thread.threadId).then((value) {
      setState(() {
        listOfChatMessages = value;
      });
    });
  }

  Future<void> addNewMessage(String message) async {
    await _addNewMessage(thread.threadId, message, thread.chatterId)
        .then((value) {
      setState(() {
        listOfChatMessages.add(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: Container(
        color: Colors.white54,
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(listOfChatMessages),
            ),
            NewMessage(
              sendMessage: addNewMessage,
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentScreen: "ChatScreen"),
    );
  }
}
