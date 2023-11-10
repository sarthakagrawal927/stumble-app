import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/bottom_app_bar.dart';

Future<List<ChatMessage>> _getChatMessages(String threadId) async {
  var messages = await getChatMessages(threadId);
  debugPrint(messages.length.toString());
  return messages.map<ChatMessage>((e) => ChatMessage.fromJson(e)).toList();
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
  bool userHasSelectedANicheOption = false;

  void setChatState(context) {
    _getChatMessages(widget.thread.threadId).then((value) {
      setState(() {
        listOfChatMessages = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isNicheFilterAlreadySelected();
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

  Future<void> isNicheFilterAlreadySelected() async {
    await getIsNicheAlreadySelected(widget.thread.threadId).then((value) {
      setState(() {
        userHasSelectedANicheOption = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isUserPlatonic =
        Provider.of<Profile>(context, listen: false).getIfUserIsPlatonic;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / 16,
        ),
        child: AppBar(
          actions: [
            if (!isUserPlatonic &&
                !userHasSelectedANicheOption) // Neither user should be platonic condition.
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  style: const TextStyle(color: Colors.blue),
                  onTap: () async {
                    // ignore: use_build_context_synchronously
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
                  items: [
                    nicheSelectedOption("Just a conversation"),
                    nicheSelectedOption("Relationship"),
                    nicheSelectedOption("Hookup"),
                  ],
                  onChanged: (itemIdentifier) async {
                    bool isSelectionSame = true;
                    if (itemIdentifier == "Just a conversation") {
                      isSelectionSame = await updateUserInterest(
                          widget.thread.threadId,
                          interestValue[InterestType.friendship]!);
                    } else if (itemIdentifier == "Hookup") {
                      isSelectionSame = await updateUserInterest(
                          widget.thread.threadId,
                          interestValue[InterestType.hookup]!);
                    } else if (itemIdentifier == "Relationship") {
                      isSelectionSame = await updateUserInterest(
                          widget.thread.threadId,
                          interestValue[InterestType.relationship]!);
                    }
                    await isNicheFilterAlreadySelected();
                    if (isSelectionSame) {
                      // ignore: use_build_context_synchronously
                      showGeneralDialog(
                        barrierColor: topAppBarColor,
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Center(
                          child: Container(
                            color: widgetColor,
                            margin: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height / 8,
                              horizontal: MediaQuery.of(context).size.width / 8,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultTextStyle(
                                style: GoogleFonts.sacramento(
                                  color: Colors.white70,
                                  fontSize: 30,
                                ),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  "You both have the same reasons for 'Stumbling' onto one another!",
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
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
                        fontSize: 35,
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

  DropdownMenuItem<String> nicheSelectedOption(final String selectedOption) {
    return DropdownMenuItem(
      value: selectedOption,
      child: Text(
        selectedOption,
        style: const TextStyle(color: whiteColor),
      ),
    );
  }

  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
