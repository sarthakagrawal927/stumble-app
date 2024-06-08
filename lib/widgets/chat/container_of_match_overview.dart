import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/general.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/individual_chats_screen.dart';
import '../circle_avatar.dart';

class ContainerOfMatchOverview extends StatefulWidget {
  const ContainerOfMatchOverview(this.threadDetails, {super.key});

  final ChatThread threadDetails;

  @override
  State<ContainerOfMatchOverview> createState() =>
      _ContainerOfMatchOverviewState();
}

class _ContainerOfMatchOverviewState extends State<ContainerOfMatchOverview> {
  Widget getStack(List<Widget> children) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width *
            0.68, // You can set a specific width here
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasConversationStarted = widget.threadDetails.lastMsgTime != null;
    String reportMessage = "";
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(thread: widget.threadDetails)));
      },
      onLongPress: () {
        showDialog(
          context: context,
          barrierColor: Colors.transparent.withOpacity(0.8),
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dialog(
                  backgroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  elevation: 16,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.825,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: marginWidth64(context)),
                                padding: EdgeInsets.symmetric(
                                  horizontal: marginWidth32(context),
                                  vertical: marginHeight64(context),
                                ),
                                child: Text(
                                  style: GoogleFonts.acme(
                                    fontSize: fontSize48(context),
                                    color: headingColor,
                                  ),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  "We encourage you to drop a message if you're reporting a user, so we can assist you promptly.",
                                ),
                              ),
                            ],
                          )),
                      Container(
                        height: marginHeight64(context),
                        color: Colors.transparent.withOpacity(0.925),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: marginHeight64(context),
                          left: marginWidth16(context),
                          right: marginWidth16(context),
                          bottom: marginHeight128(context),
                        ),
                        child: TextField(
                          maxLines: 2,
                          minLines: 1,
                          cursorColor: Colors.black,
                          autocorrect: true,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize64(context),
                          ),
                          maxLength: 25,
                          onChanged: (value) {
                            reportMessage = value;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            iconSize: fontSize16(context),
                            icon: Icon(
                              Icons.block,
                              color: Colors.black,
                              size: marginWidth12(context),
                            ),
                            onPressed: () {
                              blockUserApi(widget.threadDetails.chatterId);
                              Navigator.of(context, rootNavigator: true)
                                  .pop("");
                            },
                          ),
                          IconButton(
                            iconSize: fontSize16(context),
                            icon: Icon(
                              Icons.report,
                              color: Colors.red,
                              size: marginWidth12(context),
                            ),
                            onPressed: () {
                              reportAndBlockUserApi(
                                widget.threadDetails.chatterId,
                                2,
                                reportMessage,
                              );
                              Navigator.of(context, rootNavigator: true)
                                  .pop("");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryColor,
              width: 0.2,
            ),
          ),
          color: widgetColor,
        ),
        padding: EdgeInsets.all(
          marginWidth32(context),
        ),
        child: Row(
          children: [
            // CircleAvatarWidget(threadDetails['display_pic']),
            CircleAvatarWidget(
                marginHeight24(context), widget.threadDetails.displayPic),
            SizedBox(
              width: marginWidth24(context),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStack(
                  [
                    Flexible(
                      child: Text(
                        widget.threadDetails.name,
                        style: AppTextStyles.chatNameText(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // add a red dot to show unread
                    hasConversationStarted && widget.threadDetails.hasUserUnread
                        ? const Text(
                            "●",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.greenAccent,
                            ),
                          )
                        : hasConversationStarted &&
                                widget.threadDetails.yourMove
                            ? Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Badge(
                                  isLabelVisible: false,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          512,
                                      right: marginWidth128(context),
                                    ),
                                    decoration: const BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(200),
                                      ),
                                    ),
                                    child: const Text(
                                      "Your Move!",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                  ],
                ),
                getStack([
                  Flexible(
                    child: Text(
                      hasConversationStarted
                          ? widget.threadDetails.message
                          : "Conversation not started yet",
                      style: TextStyle(
                        fontSize: 12.5,
                        color: textColor,
                        fontStyle: hasConversationStarted
                            ? FontStyle.normal
                            : FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,

                      // italics if hasConversationStarted
                    ),
                  ),
                  Text(
                      hasConversationStarted
                          ? beautifyTime(
                              widget.threadDetails.lastMsgTime as DateTime)
                          : "",
                      style: const TextStyle(fontSize: 12.5, color: textColor)),
                ]),
              ],
            ),
            // add time at end
          ],
        ),
      ),
    );
  }
}
