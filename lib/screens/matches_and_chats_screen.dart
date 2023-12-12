import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/screens/individual_chats_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/matches_conversation_started_with.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool _listsPopulated = false;

  @override
  void initState() {
    super.initState();
    Future<List<MiniProfile>> matchesFuture = _getMatches();
    Future<List<ChatThread>> threadsFuture = _getThreads();

    Future.wait([matchesFuture, threadsFuture]).then((List<dynamic> results) {
      setState(() {
        listOfStumbleMatches = results[0] as List<MiniProfile>;
        listOfMatchesConversationStartedWith = results[1] as List<ChatThread>;
        _listsPopulated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widgetColor,
      appBar: TopAppBar(
        routeName: "",
      ),
      body: Container(
        color: backgroundColor,
        child: _listsPopulated &&
                listOfStumbleMatches.isEmpty &&
                listOfMatchesConversationStartedWith.isEmpty
            ? Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 8,
                    horizontal: MediaQuery.of(context).size.width / 8,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "You haven't 'Stumbled' into anyone yet; keep swiping!",
                    style: GoogleFonts.sacramento(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: MatchesConversationStartedWith(
                        listOfMatchesConversationStartedWith),
                  ),
                ],
              ),
      ),
      bottomNavigationBar:
          const BottomBar(currentScreen: BottomBarScreens.chatScreen),
    );
  }
}
