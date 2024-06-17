import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:dating_made_better/widgets/common/info_dialog_widget.dart';
import 'package:dating_made_better/widgets/common/prompt_dialog.dart';
import 'package:dating_made_better/widgets/dropdown_options_constants.dart';
import 'package:dating_made_better/widgets/generic_dialog_widget.dart';
import 'package:dating_made_better/widgets/interest_types_constants.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/bottom_app_bar.dart';

class ChatApiResponse {
  final List<ChatMessage> messages;
  final bool? lookingForSame;
  final bool? showLookingForOption;
  final InterestType? lookingFor;
  final bool? isBlocked;

  ChatApiResponse(this.messages, this.lookingFor, this.showLookingForOption,
      this.lookingForSame, this.isBlocked);
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
      apiResponse["lookingForSame"],
      apiResponse["isBlocked"]);
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
  bool isBlocked = false;
  late InterestType? lookingFor;

  bool userHasSelectedANicheOption = false;

  void setChatState(context) {
    _getChatMessages(widget.thread.threadId).then((value) {
      setState(() {
        listOfChatMessages = value.messages;
        showLookingForOption = value.showLookingForOption ?? false;
        showLookingForOptionColor = showLookingForOptionColor;
        lookingForSame = value.lookingForSame ?? false;
        lookingFor = value.lookingFor;
        isBlocked = value.isBlocked ?? false;
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        leadingWidth: marginWidth16(context),
        actions: [
          DropdownButtonHideUnderline(
              child: DropdownButton(
            icon: Padding(
              padding: EdgeInsets.only(right: marginWidth16(context)),
              child: const Icon(
                Icons.more_vert,
                color: headingColor,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
            dropdownColor: AppColors.backgroundColor,
            iconSize: marginWidth16(context),
            items: getDropDownMenuList(
                context, individualChatScreenDropdownOptions),
            onChanged: (itemIdentifier) async {
              if (itemIdentifier == 'Block') {
                blockUserApi(widget.thread.chatterId);
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed(MatchesAndChatsScreen.routeName);
              } else if (itemIdentifier == 'Report') {
                genericDialogWidget(context,
                    reason: PromptReason.reportUser,
                    chatterId: widget.thread.chatterId);
              }
            },
          ))
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  marginWidth16(context), widget.thread.displayPic),
            ),
            SizedBox(
              width: marginWidth128(context),
            ),
            Padding(
              padding: EdgeInsets.only(left: marginWidth64(context)),
              child: SizedBox(
                  width: marginWidth4(context),
                  child: Text(widget.thread.name.split(" ").first,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.chatNameText(context))),
            ),
            const Spacer(),
            showLookingForOption
                ? DropdownButtonHideUnderline(
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: AppColors.backgroundColor,
                      onTap: () async {
                        await showModelIfNotShown(
                            context, ModelOpened.userInterestInfoTeaching);
                      },
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
                              context,
                              promptExplainingStumblingReason,
                            );
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
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                : Container()
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
          isBlocked
              ? Text("You have blocked this user",
                  style: AppTextStyles.regularText(context))
              : NewMessage(
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
        style: AppTextStyles.dropdownText(context),
      ),
    );
  }

  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
