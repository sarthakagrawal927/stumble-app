import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
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
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> listOfChatMessages = [];
  bool userHasSelectedANicheOption = false;
  late ChatThread thread;

  void setChatState(context) {
    thread = (ModalRoute.of(context)?.settings.arguments) as ChatThread;
    _getChatMessages(thread.threadId).then((value) {
      setState(() {
        listOfChatMessages = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setChatState(context));
  }

  Future<void> addNewMessage(String message) async {
    await _addNewMessage(thread.threadId, message, thread.chatterId)
        .then((value) {
      setState(() {
        listOfChatMessages.add(value);
      });
    });
  }

  Future<void> isNicheFilterAlreadySelected() async {
    await getIsNicheAlreadySelected(thread.threadId).then((value) {
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
            if (!isUserPlatonic && !userHasSelectedANicheOption)
              DropdownButton(
                onTap: () async {
                  await isNicheFilterAlreadySelected();
                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height / 4,
                                  horizontal:
                                      MediaQuery.of(context).size.width / 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListView(
                                  children: const [
                                    TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'About these options:'),
                                    ),
                                    Text(
                                        "These options are the niche feature of our app when it comes to non-platonic relationships. You can choose what you want with each individual. NOTE: Be rest-assured, your selected option would not be shown to the other person; until and unless, they have selected the same option. This is done to minimize the fear of judgement people may have before selecting an option.")
                                  ],
                                ),
                              ),
                            ));
                      });
                },
                dropdownColor: backgroundColor,
                items: [
                  nicheSelectedOption("Just a conversation"),
                  nicheSelectedOption("Relationship"),
                  nicheSelectedOption("Hookup"),
                ],
                onChanged: (itemIdentifier) async {
                  if (userHasSelectedANicheOption) {
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 6,
                            vertical: MediaQuery.of(context).size.width / 8),
                        child: const Dialog(
                          child: Text(
                            "You have already selected an option!",
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: widgetColor,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  } else {
                    bool isSelectionSame = false;
                    if (itemIdentifier == "Just a conversation") {
                      isSelectionSame = await updateUserInterest(
                          thread.threadId,
                          interestValue[InterestType.friendship]!);
                    } else if (itemIdentifier == "Hookup") {
                      isSelectionSame = await updateUserInterest(
                          thread.threadId, interestValue[InterestType.hookup]!);
                    } else if (itemIdentifier == "Relationship") {
                      isSelectionSame = await updateUserInterest(
                          thread.threadId,
                          interestValue[InterestType.relationship]!);
                    }
                    await isNicheFilterAlreadySelected();
                    if (isSelectionSame) {
                      // ignore: use_build_context_synchronously
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Text(
                                "You both have the same reasons for stumbling onto one another!"),
                      );
                    }
                  }
                },
                icon: const Icon(
                  Icons.menu,
                  color: headingColor,
                ),
              )
          ],
          backgroundColor: topAppBarColor,
          title: Row(
            children: [
              GestureDetector(
                child: CircleAvatarWidget(35, thread.displayPic),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 64),
                child: const Text(
                  'Stumble!',
                  style: TextStyle(
                      fontSize: 25,
                      color: headingColor,
                      fontWeight: FontWeight.w900),
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
      child: Row(
        children: [
          Text(
            selectedOption,
            style: const TextStyle(color: whiteColor),
          ),
        ],
      ),
    );
  }

  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
