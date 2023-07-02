import 'package:dating_made_better/widgets/chat/matches_conversation_started_with.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/top_app_bar.dart';

class MatchesAndChatsScreen extends StatefulWidget {
  static const routeName = '/matches-and-chats-screen';

  const MatchesAndChatsScreen({super.key});

  @override
  State<MatchesAndChatsScreen> createState() => _MatchesAndChatsScreenState();
}

class _MatchesAndChatsScreenState extends State<MatchesAndChatsScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> listOfStumbleMatches =
        Provider.of<Profile>(context, listen: false)
            .currentListOfMatchesForCurrentUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TopAppBar(),
      body: Container(
        color: const Color.fromRGBO(26, 28, 29, 1),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 32,
                        bottom: MediaQuery.of(context).size.width / 32,
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(listOfStumbleMatches.length,
                            (int index) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 32,
                              right: MediaQuery.of(context).size.width / 32,
                            ),
                            color: const Color.fromRGBO(15, 15, 15, 0.2),
                            child:
                                listOfStumbleMatches[index]['photos'][0] != null
                                    ? (listOfStumbleMatches[index]['photos'][0])
                                    : null,
                          );
                        }),
                      ),
                    ),
                  ),
                  const MatchesConversationStartedWith(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentScreen: "ChatScreen"),
    );
  }
}
