import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/matches_conversation_started_with.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/top_app_bar.dart';

Future<List<MiniProfile>> _getMatches() async {
  var profiles = await getMatches();
  debugPrint(profiles.length.toString());
  return profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList();
}

Future<List<ChatThread>> _getThreads() async {
  var threads = await getThreads();
  debugPrint(threads.length.toString());
  return threads.map<ChatThread>((e) => ChatThread.fromJson(e)).toList();
}

class MatchesAndChatsScreen extends StatefulWidget {
  static const routeName = '/matches-and-chats-screen';

  const MatchesAndChatsScreen({super.key});

  @override
  State<MatchesAndChatsScreen> createState() => _MatchesAndChatsScreenState();
}

class _MatchesAndChatsScreenState extends State<MatchesAndChatsScreen> {
  List<MiniProfile> listOfStumbleMatches = [];
  List<ChatThread> listOfMatchesConversationStartedWith = [];

  @override
  void initState() {
    super.initState();
    Future<List<MiniProfile>> matchesFuture = _getMatches();
    Future<List<ChatThread>> threadsFuture = _getThreads();

    Future.wait([matchesFuture, threadsFuture]).then((List<dynamic> results) {
      setState(() {
        listOfStumbleMatches = results[0] as List<MiniProfile>;
        listOfMatchesConversationStartedWith = results[1] as List<ChatThread>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TopAppBar(),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(listOfStumbleMatches.length,
                          (int index) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 32,
                            bottom: MediaQuery.of(context).size.height / 32,
                            left: MediaQuery.of(context).size.width / 32,
                            right: MediaQuery.of(context).size.width / 32,
                          ),
                          child: CircleAvatarWidget(
                              35,
                              listOfStumbleMatches[index].photo ??
                                  defaultBackupImage),
                        );
                      }),
                    ),
                  ),
                  MatchesConversationStartedWith(
                      listOfMatchesConversationStartedWith),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomBar(currentScreen: BottomBarScreens.chatScreen),
    );
  }
}
