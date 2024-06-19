import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/chat/chat_messages.dart';
import 'package:dating_made_better/widgets/chat/new_message.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:dating_made_better/widgets/common/menu_dropdown.dart';
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

  Future<void> handleNicheSelection(InterestType interest) async {
    updateUserInterest(widget.thread.threadId, interestValue[interest]!)
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
          MenuDropdown(const Icon(Icons.more_vert), [
            DropdownOptionParams(
              value: 'Report',
              icon: Icons.report,
              onClick: () => {
                genericDialogWidget(context,
                    reason: PromptReason.reportUser,
                    extraParams: {
                      badActorIdKey: widget.thread.chatterId,
                      reportSourceKey: reportSourceChat
                    }),
              },
            ),
            !isBlocked
                ? DropdownOptionParams(
                    value: 'Block',
                    icon: Icons.block,
                    onClick: () => {
                      blockUserApi(widget.thread.chatterId).then((value) {
                        setState(() {
                          isBlocked = true;
                        });
                      }),
                    },
                  )
                : DropdownOptionParams(
                    value: 'Unblock',
                    icon: Icons.block_outlined,
                    onClick: () => {
                      unblockUserApi(widget.thread.chatterId).then((value) => {
                            setState(() {
                              isBlocked = false;
                            })
                          })
                    },
                  )
          ]),
          showLookingForOption
              ? MenuDropdown(
                  const Icon(Icons.remove_red_eye_outlined),
                  interestToLabel.entries
                      .map((e) => DropdownOptionParams(
                            onClick: () => handleNicheSelection(e.key),
                            value: e.value.toString(),
                          ))
                      .toList(),
                )
              : Container(),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: GestureDetector(
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
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatarWidget(
                          marginWidth16(context), widget.thread.displayPic),
                      Padding(
                        padding: EdgeInsets.only(left: marginWidth32(context)),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(widget.thread.name.split(" ").first,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.chatNameText(context))),
                      )
                    ],
                  )),
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
}
