import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dating_made_better/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final currentUser = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemBuilder: ((context, index) => MessageBubble(
                snapshot.data?.docs[index]['text'],
                snapshot.data?.docs[index]['userId'] == currentUser!.uid,
                key: ValueKey(
                  snapshot.data?.docs[index].id,
                ),
              )),
          itemCount: snapshot.data!.docs.length,
        );
      }),
    );
  }
}
