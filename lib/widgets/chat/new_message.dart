import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants_colors.dart';
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

  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widgetColor,
      margin: const EdgeInsets.only(
        top: 8.0,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _controller,
              autovalidateMode: AutovalidateMode.always,
              validator: ((value) {
                if (value!.contains("\n")) {
                  DoNothingAction;
                }
                return null;
              }),
              maxLines: null,
              style:
                  const TextStyle(color: AppColors.primaryColor, height: 0.6),
              cursorColor: whiteColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                labelText: 'Send a message',
                labelStyle:
                    TextStyle(fontSize: 12, color: AppColors.primaryColor),
              ),
              onChanged: (value) {
                _enteredMessage = value.toString();
              },
            ),
          ),
          IconButton(
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
              Icons.send_rounded,
              color: AppColors.secondaryColor,
            ),
          )
        ],
      ),
    );
  }
}
