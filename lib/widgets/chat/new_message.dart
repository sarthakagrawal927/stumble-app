import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = "";
  final _controller = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': DateTime.now(),
      'userId': user!.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(38, 41, 42, 1),
      margin: const EdgeInsets.only(
        top: 8.0,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(
                color: Color.fromRGBO(237, 237, 237, 1),
              ),
              cursorColor: const Color.fromRGBO(237, 237, 237, 1),
              decoration: const InputDecoration(
                labelText: 'Send a message!',
                labelStyle: TextStyle(color: Color.fromRGBO(15, 15, 15, 1)),
              ),
              onChanged: (value) {
                _enteredMessage = value;
              },
            ),
          ),
          IconButton(
            color: const Color.fromRGBO(38, 41, 42, 1),
            onPressed: () {
              _enteredMessage.trim().isEmpty ? null : _sendMessage();
            },
            icon: const Icon(
              Icons.send,
              color: Color.fromRGBO(237, 237, 237, 1),
            ),
          )
        ],
      ),
    );
  }
}
