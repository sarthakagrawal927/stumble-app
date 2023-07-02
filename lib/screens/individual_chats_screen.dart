import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_app_bar.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: Container(
        color: Colors.white54,
        child: Column(
          children: const [
            Expanded(
              child: ChatMessages(),
            ),
            NewMessage()
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentScreen: "ChatScreen"),
    );
  }
}
