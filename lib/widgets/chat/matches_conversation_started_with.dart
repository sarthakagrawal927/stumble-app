import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/widgets/chat/container_of_match_overview.dart';
import 'package:flutter/material.dart';

class MatchesConversationStartedWith extends StatelessWidget {
  const MatchesConversationStartedWith(
    this.listOfMatchesConversationStartedWith, {
    super.key,
  });
  final List<ChatThread> listOfMatchesConversationStartedWith;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      reverse: false,
      itemBuilder: ((context, index) => ContainerOfMatchOverview(
            listOfMatchesConversationStartedWith[index],
            key: ValueKey(listOfMatchesConversationStartedWith[index].threadId),
          )),
      itemCount: listOfMatchesConversationStartedWith.length,
    );
  }
}
