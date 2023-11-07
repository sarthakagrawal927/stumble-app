import 'package:flutter/material.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class NewMessage extends StatelessWidget {
  String _enteredMessage = "";
  bool isLoading = false;
  final Future<void> Function(String) sendMessage;
  NewMessage({required this.sendMessage, super.key});
  // receive sendMessage function from caller

  final _controller = TextEditingController();

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
                color: whiteColor,
              ),
              cursorColor: whiteColor,
              decoration: const InputDecoration(
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
            onPressed: () async {
              if (isLoading || _enteredMessage.trim().isEmpty) return;
              isLoading = true;
              try {
                await sendMessage(_enteredMessage);
              } catch (err) {
                debugPrint(err.toString());
              } finally {
                isLoading = false;
                FocusManager.instance.primaryFocus?.unfocus();
              }
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
