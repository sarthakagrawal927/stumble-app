import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../widgets/bottom_app_bar.dart';

const interestToLabel = {
  InterestType.friendship: "Just a conversation",
  InterestType.hookup: "Hookup",
  InterestType.relationship: "Relationship",
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
  bool lookingForSame = false;
  late InterestType? lookingFor;

  bool userHasSelectedANicheOption = false;

  void setChatState(context) {
    _getChatMessages(widget.thread.threadId).then((value) {
      setState(() {
        listOfChatMessages = value.messages;
        showLookingForOption = value.showLookingForOption;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / 16,
        ),
        child: AppBar(
          actions: [
            if (showLookingForOption)
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  style: const TextStyle(color: Colors.blue),
                  onTap: () {
                    // Show only once for every user, using localStorage
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: Dialog(
                                  backgroundColor: widgetColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  64,
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  12),
                                          child: Text(
                                            'About these options:',
                                            style: GoogleFonts.sacramento(
                                                fontSize: 35,
                                                color: headingColor,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  64,
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  12),
                                          child: const Text(
                                            "Our app offers unique features for non-platonic relationships, allowing you to privately select preferences for each individual. Rest assured, your choices remain confidential unless both parties select the same option, reducing fear of judgment during the selection process.",
                                            style:
                                                TextStyle(color: headingColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        });
                  },
                  dropdownColor: backgroundColor,
                  items: labelToInterest.entries
                      .map((e) => nicheSelectedOption(e.value))
                      .toList(),
                  onChanged: (itemIdentifier) async {
                    InterestType interest = labelToInterest[itemIdentifier]!;
                    updateUserInterest(
                            widget.thread.threadId, interestValue[interest]!)
                        .then((sameInterest) {
                      if (sameInterest) {
                        String interestLabel = interestToLabel[interest]!;
                        setState(() {
                          lookingForSame = true;
                          lookingFor = interest;
                          showLookingForOption = false;
                        });
                        // ignore: use_build_context_synchronously
                        showGeneralDialog(
                          barrierColor: topAppBarColor,
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Center(
                            child: Container(
                              color: widgetColor,
                              margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height / 8,
                                horizontal:
                                    MediaQuery.of(context).size.width / 8,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DefaultTextStyle(
                                  style: GoogleFonts.sacramento(
                                    color: Colors.white70,
                                    fontSize: 30,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'You both have the same reason $interestLabel for "Stumbling" onto one another!',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          showLookingForOption = false;
                        });
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: headingColor,
                  ),
                ),
              )
          ],
          backgroundColor: topAppBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: CircleAvatarWidget(
                    MediaQuery.of(context).size.height / 40,
                    widget.thread.displayPic),
                onTap: () {},
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 32,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 64),
                child: Flexible(
                  child: Text(
                    widget.thread.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sacramento(
                        fontSize: 25,
                        color: headingColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          if (lookingForSame)
            Text(
              'Looking for same: ${interestToLabel[lookingFor]}',
              style: const TextStyle(color: whiteColor),
            ),
          Expanded(
            child: ChatMessages(listOfChatMessages),
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
        style: const TextStyle(color: whiteColor),
      ),
    );
  }

  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
