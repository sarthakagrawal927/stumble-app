import 'package:dating_made_better/widgets/chat/container_of_match_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile.dart';

class MatchesConversationStartedWith extends StatelessWidget {
  const MatchesConversationStartedWith({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> listOfMatchesConversationStartedWith =
        Provider.of<Profile>(context).threadsListForCurrentUser;
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      reverse: false,
      itemBuilder: ((context, index) => ContainerOfMatchOverview(
            listOfMatchesConversationStartedWith[index],
            key: ValueKey(
              listOfMatchesConversationStartedWith[index]['thread_id'],
            ),
          )),
      itemCount: listOfMatchesConversationStartedWith.length,
    );
  }
}
