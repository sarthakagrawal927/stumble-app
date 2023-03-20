import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/bottom_app_bar.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      debugPrint("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: Container(
        color: const Color.fromRGBO(26, 28, 29, 1),
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
