import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:dating_made_better/widgets/common/info_dialog_widget.dart';
import 'package:dating_made_better/widgets/common/prompt_dialog.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../widgets/bottom_app_bar.dart';

var interestToLabel = {
  InterestType.friendship: "Just a conversation",
  InterestType.hookup: "🌚",
  InterestType.relationship: "💞",
};

var labelToInterest = {
  interestToLabel[InterestType.friendship]: InterestType.friendship,
  interestToLabel[InterestType.hookup]: InterestType.hookup,
  interestToLabel[InterestType.relationship]: InterestType.relationship,
};

class ChatApiResponse {
  final List<ChatMessage> messages;
  final bool lookingForSame;
  final bool showLookingForOption;
  final InterestType? lookingFor;

  ChatApiResponse(this.messages, this.lookingFor, this.showLookingForOption,
      this.lookingForSame);
}

Future<ChatApiResponse> _getChatMessages(String threadId) async {
  var apiResponse = await getChatMessages(threadId);
  var messages = apiResponse['messages'] as List<dynamic>;
  int? lookingFor = apiResponse["lookingFor"];
  InterestType? lookingForInterest = lookingFor != null
      ? InterestType.values.firstWhere((e) => (e.index + 1) == lookingFor,
          orElse: () => InterestType.friendship)
      : null;
  return ChatApiResponse(
      messages.map<ChatMessage>((e) => ChatMessage.fromJson(e)).toList(),
      lookingForInterest,
      apiResponse["showLookingForOption"],
      apiResponse["lookingForSame"]);
}

Future<ChatMessage> _addNewMessage(
    String threadId, String message, int receiverId) async {
  return await addChatMessage(threadId, message, receiverId);
}

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  final ChatThread thread;
  const ChatScreen({super.key, required this.thread});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> listOfChatMessages = [];
  bool showLookingForOption = false;
  Color showLookingForOptionColor = topAppBarColor;
  bool lookingForSame = false;
  bool profileLoading = false;
  late InterestType? lookingFor;

  bool userHasSelectedANicheOption = false;

  void setChatState(context) {
    _getChatMessages(widget.thread.threadId).then((value) {
      setState(() {
        listOfChatMessages = value.messages;
        showLookingForOption = value.showLookingForOption;
        showLookingForOptionColor = showLookingForOptionColor;
        lookingForSame = value.lookingForSame;
        lookingFor = value.lookingFor;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setChatState(context));
  }

  Future<void> addNewMessage(String message) async {
    await _addNewMessage(
            widget.thread.threadId, message, widget.thread.chatterId)
        .then((value) {
      setState(() {
        listOfChatMessages.add(value);
      });
    }).catchError((err) {
      throw err;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // temporary solution until proper global state management is implemented
          onPressed: () =>
              Navigator.of(context).pushNamed(MatchesAndChatsScreen.routeName),
        ),
        backgroundColor: topAppBarColor,
        title: Row(
          children: [
            GestureDetector(
              onDoubleTap: () => DoNothingAction(),
              onTap: () async {
                if (profileLoading) return;
                profileLoading = true;
                await getUserApi(widget.thread.chatterId)
                    .then((value) => showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SwipeCard(
                              profile: value!,
                              isModalMode: true,
                            );
                          },
                        ));
                profileLoading = false;
              },
              child: CircleAvatarWidget(
                  marginWidth24(context), widget.thread.displayPic),
            ),
            SizedBox(
              width: marginWidth64(context),
            ),
            Padding(
              padding: EdgeInsets.only(left: marginWidth64(context)),
              child: SizedBox(
                width: marginWidth4(context),
                child: Text(
                  widget.thread.name.split(" ").first,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.sacramento(
                      fontSize: marginWidth16(context),
                      color: headingColor,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const Spacer(),
            showLookingForOption
                ? DropdownButtonHideUnderline(
                    child: DropdownButton(
                      onTap: () async {
                        await showModelIfNotShown(
                            context, ModelOpened.userInterestInfoTeaching);
                      },
                      dropdownColor: backgroundColor,
                      items: labelToInterest.entries
                          .map((e) => nicheSelectedOption(e.value))
                          .toList(),
                      onChanged: (itemIdentifier) async {
                        InterestType interest =
                            labelToInterest[itemIdentifier]!;
                        updateUserInterest(widget.thread.threadId,
                                interestValue[interest]!)
                            .then((sameInterest) {
                          if (sameInterest) {
                            setState(() {
                              lookingForSame = true;
                              lookingFor = interest;
                              showLookingForOption = false;
                            });
                            promptDialog(
                                context, promptExplainingStumblingReason,);
                          } else {
                            setState(() {
                              showLookingForOption = false;
                            });
                          }
                        });
                      },
                      icon: Icon(
                        Icons.visibility,
                        size: marginWidth12(context),
                        color: headingColor,
                      ),
                    ),
                  )
                : Icon(
                    Icons.visibility_off,
                    size: marginWidth12(context),
                    color: topAppBarColor,
                  ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (lookingForSame)
            Container(
              color: backgroundColor,
              margin: EdgeInsets.symmetric(
                vertical: marginHeight64(context),
                horizontal: marginWidth64(context),
              ),
              padding: EdgeInsets.symmetric(
                vertical: marginHeight64(context),
                horizontal: marginWidth64(context),
              ),
              child: Text(
                'Looking for same: ${interestToLabel[lookingFor]}',
                style: const TextStyle(color: headingColor),
              ),
            ),
          Expanded(
            child: ChatMessages(listOfChatMessages, widget.thread.displayPic),
          ),
          NewMessage(
            sendMessage: addNewMessage,
          )
        ],
      ),
      bottomNavigationBar:
          const BottomBar(currentScreen: BottomBarScreens.chatScreen),
    );
  }

  DropdownMenuItem<String> nicheSelectedOption(
      final InterestType selectedOption) {
    return DropdownMenuItem(
      value: interestToLabel[selectedOption],
      child: Text(
        interestToLabel[selectedOption]!,
        style: const TextStyle(color: headingColor),
      ),
    );
  }

  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
