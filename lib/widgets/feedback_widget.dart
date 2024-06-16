import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

Future<dynamic> feedbackWidget(BuildContext context) {
  String phoneNumber = "";
  String feedback = "";
  TextEditingController controller = TextEditingController();

  return showDialog(
                    context: context,
                    barrierColor: Colors.transparent.withOpacity(0.8),
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            elevation: 16,
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                SizedBox(
                                    height: marginHeight4(context),
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.825,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  64),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    32,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                64,
                                          ),
                                          child: Text(
                                            style: GoogleFonts.acme(
                                              fontSize:
                                                  marginWidth16(context),
                                              color: headingColor,
                                            ),
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            "We'd love to hear YOU, to make stumbling a better experience for YOU!",
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  height: marginHeight64(context),
                                  color:
                                      Colors.transparent.withOpacity(0.925),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      marginWidth12(context)),
                                  child: TextField(
                                    maxLines: 2,
                                    minLines: 1,
                                    cursorColor: Colors.black,
                                    autocorrect: true,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction:
                                        TextInputAction.newline,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    maxLength: 75,
                                    onChanged: (value) {
                                      feedback = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: marginWidth64(context),
                                    vertical: marginHeight128(context),
                                  ),
                                  child: InternationalPhoneNumberInput(
                                    cursorColor: headingColor,
                                    onInputChanged: (PhoneNumber number) {
                                      phoneNumber = number.phoneNumber!;
                                    },
                                    selectorConfig: const SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.DIALOG,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    selectorTextStyle: const TextStyle(
                                        color: headingColor),
                                    autoFocus: true,
                                    hintText: "Phone number",
                                    keyboardAction: TextInputAction.done,
                                    textFieldController: controller,
                                    textStyle: const TextStyle(
                                        color: headingColor),
                                    formatInput: true,
                                    keyboardType: const TextInputType
                                        .numberWithOptions(
                                        signed: true, decimal: true),
                                    inputBorder: const OutlineInputBorder(),
                                    onFieldSubmitted: (value) {
                                      phoneNumber = value;
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      iconSize: MediaQuery.of(context)
                                              .size
                                              .width /
                                          10,
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop("");
                                      },
                                    ),
                                    IconButton(
                                      iconSize: MediaQuery.of(context)
                                              .size
                                              .width /
                                          10,
                                      icon: const Icon(
                                        Icons.check,
                                      ),
                                      onPressed: () {
                                        sendFeedbackApi(
                                            phoneNumber, feedback);
                                        Navigator.of(context,
                                                rootNavigator: true)
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
}
