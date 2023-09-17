import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/matches_conversation_started_with.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/top_app_bar.dart';

Future<List<MiniProfile>> _getMatches() async {
  var profiles = await getMatches();
  debugPrint(profiles.length.toString());
  return profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList();
}

class MatchesAndChatsScreen extends StatefulWidget {
  static const routeName = '/matches-and-chats-screen';

  const MatchesAndChatsScreen({super.key});

  @override
  State<MatchesAndChatsScreen> createState() => _MatchesAndChatsScreenState();
}

class _MatchesAndChatsScreenState extends State<MatchesAndChatsScreen> {
  List<MiniProfile> listOfStumbleMatches = [];
  List<MiniProfile> listOfMatchesConversationStartedWith = [];

  @override
  void initState() {
    super.initState();
    _getMatches().then((values) {
      setState(() {
        listOfStumbleMatches = values;
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
                              // color: widgetColor,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          listOfStumbleMatches[index].photo ??
                                              defaultBackupImage))),
                              child: Text(
                                listOfStumbleMatches[index].name,
                              ));
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
