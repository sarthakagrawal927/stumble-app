import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = "";
  String _threadId = "";
  int _currentUser = -1;
  final _controller = TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    Map<String, dynamic> response =
        await Provider.of<Profile>(context, listen: false)
            .addMessageAPI(_enteredMessage, _currentUser, _threadId);
    // ignore: use_build_context_synchronously
    Provider.of<Profile>(context, listen: false)
        .addMessageToMessagesList(response);
    _enteredMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = Provider.of<Profile>(context, listen: false).currentUser;
    _threadId = Provider.of<Profile>(context, listen: false).currentThreadId;
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
                color: whiteColor,
              ),
              cursorColor: whiteColor,
              decoration: InputDecoration(
                labelText: 'Send a message!',
                labelStyle: TextStyle(color: backgroundColor),
              ),
              onChanged: (value) {
                _enteredMessage = value.toString();
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
              color: whiteColor,
            ),
          )
        ],
      ),
    );
  }
}
