import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/3td5aCTdkTivEuuwTj7q/messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      documents[index]['text'],
                    ),
                  )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/3td5aCTdkTivEuuwTj7q/messages')
              .add({'text': 'This is the second entry!'});
        },
      ),
      bottomNavigationBar: BottomBar(currentScreen: "ChatScreen"),
    );
  }
}
