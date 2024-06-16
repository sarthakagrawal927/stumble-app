import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';

Future<dynamic> reportDialog(BuildContext context, int chatterId) {
  String reportMessage = "";
    return showDialog(
                    context: context,
                    barrierColor: Colors.transparent.withOpacity(0.5),
                    builder: (context) {
                      return Dialog(
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))),
          
                        child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: marginWidth32(context),
                            vertical: marginHeight128(context),
                          ),
                          child: Text(
                            "We encourage you to drop a message if you're reporting a user, so we can assist you promptly.",
                            style: AppTextStyles.regularText(context),
                          ),
                        ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: marginWidth32(context),
                              vertical: marginHeight128(context),
                            ),
                            child: TextField(
                                                      maxLines: 2,
                                                      minLines: 1,
                                                      cursorColor: Colors.black,
                                                      autocorrect: true,
                                                      keyboardType: TextInputType.multiline,
                                                      textInputAction: TextInputAction.newline,
                                                      style: AppTextStyles.descriptionText(context),
                                                      maxLength: 25,
                                                      onChanged: (value) {
                            reportMessage = value;
                                                      },
                                                    ),
                          ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                              horizontal: marginWidth32(context),
                              vertical: marginHeight128(context),
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          IconButton(
                            iconSize: fontSize16(context),
                            icon: Icon(
                              Icons.check_circle_rounded,
                              color: Colors.black,
                              size: marginWidth12(context),
                            ),
                            onPressed: () {
                              reportAndBlockUserApi(chatterId, 2, reportMessage);
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacementNamed(MatchesAndChatsScreen.routeName);
                            },
                          ),
                          IconButton(
                            iconSize: fontSize16(context),
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.black,
                              size: marginWidth12(context),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop("");
                            },
                          ),
                        ],),
                      )
                        ],
                      ));
                    });
  }
