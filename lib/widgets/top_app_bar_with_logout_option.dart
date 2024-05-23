import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../utils/internal_storage.dart';

enum DropdownOptions {
  feedback,
  logout,
  delete,
  privacy,
}

class DropdownOptionVal {
  final String value;
  final IconData icon;
  final DropdownOptions dropdownOption;

  DropdownOptionVal(this.value, this.icon, this.dropdownOption);
}

var defaultDropdownOptions = [
  DropdownOptionVal("Leave feedback!", Icons.pages, DropdownOptions.feedback),
  DropdownOptionVal(
      "Privacy terms", Icons.document_scanner, DropdownOptions.privacy),
  DropdownOptionVal("Logout", Icons.exit_to_app, DropdownOptions.logout),
  DropdownOptionVal("Delete :'(", Icons.emoji_flags, DropdownOptions.delete),
];

// ignore: must_be_immutable
class TopAppBarWithLogoutOption extends StatelessWidget
    implements PreferredSizeWidget {
  String routeName;
  TopAppBarWithLogoutOption({required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    String phoneNumber = "";
    String feedback = "";

    return PreferredSize(
      preferredSize: Size.fromHeight(
        marginHeight16(context),
      ),
      child: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: routeName != ""
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: headingColor),
                // temporary solution until proper global state management is implemented
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(routeName),
              )
            : null,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              iconSize: marginWidth16(context),
              dropdownColor: dropDownColor,
              items: defaultDropdownOptions
                  .map((e) => DropdownMenuItem(
                        value: e.value,
                        child: Row(
                          children: [
                            Icon(e.icon, color: whiteColor),
                            const SizedBox(width: 8),
                            Text(e.value,
                                style: const TextStyle(color: whiteColor)),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (itemIdentifier) async {
                if (itemIdentifier == 'Logout') {
                  deleteSecureData(authKey).then((value) {
                    Provider.of<FirstScreenStateProviders>(context,
                            listen: false)
                        .setActiveScreenMode(ScreenMode.landing);
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  });
                } else if (itemIdentifier == 'Privacy terms') {
                  launchUrl(Uri.parse('https://www.getstumble.app/privacy'));
                } else if (itemIdentifier == 'Delete :\'(') {
                  showDialog(
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
                                      width: MediaQuery.of(context).size.width *
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
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  32,
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  64,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  style: GoogleFonts.acme(
                                                    fontSize:
                                                        marginWidth16(context),
                                                    color: headingColor,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  softWrap: true,
                                                  "It saddens us to witness your stumbling come to a halt in discovering more incredible individuals!",
                                                ),
                                                SizedBox(
                                                    height: marginHeight64(
                                                        context)),
                                                Text(
                                                    style: GoogleFonts.acme(
                                                      fontSize: marginWidth32(
                                                              context) /
                                                          1.5,
                                                      color: headingColor,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    softWrap: true,
                                                    "Click on the ✅ to delete.")
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    height: marginHeight64(context),
                                    color:
                                        Colors.transparent.withOpacity(0.925),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        iconSize:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop("");
                                        },
                                      ),
                                      IconButton(
                                        iconSize:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        icon: const Icon(
                                          Icons.check,
                                        ),
                                        onPressed: () {
                                          deleteUserApi().then((_) =>
                                              deleteSecureData(authKey)
                                                  .then((value) {
                                                Provider.of<FirstScreenStateProviders>(
                                                        context,
                                                        listen: false)
                                                    .setActiveScreenMode(
                                                        ScreenMode.landing);
                                                Navigator.pushNamed(context,
                                                    AuthScreen.routeName);
                                              }));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                } else if (itemIdentifier == 'Leave feedback!') {
                  showDialog(
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
                                    width: MediaQuery.of(context).size.width *
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
                                            horizontal: MediaQuery.of(context)
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
                                              fontSize: marginWidth16(context),
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
                                  color: Colors.transparent.withOpacity(0.925),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.all(marginWidth12(context)),
                                  child: TextField(
                                    maxLines: 2,
                                    minLines: 1,
                                    cursorColor: Colors.black,
                                    autocorrect: true,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
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
                                    selectorTextStyle:
                                        const TextStyle(color: headingColor),
                                    autoFocus: true,
                                    hintText: "Phone number",
                                    keyboardAction: TextInputAction.done,
                                    textFieldController: controller,
                                    textStyle:
                                        const TextStyle(color: headingColor),
                                    formatInput: true,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
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
                                      iconSize:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop("");
                                      },
                                    ),
                                    IconButton(
                                      iconSize:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      icon: const Icon(
                                        Icons.check,
                                      ),
                                      onPressed: () {
                                        sendFeedbackApi(phoneNumber, feedback);
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
              },
              icon: Padding(
                padding: EdgeInsets.only(right: marginWidth16(context)),
                child: const Icon(
                  Icons.menu,
                  color: headingColor,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: topAppBarColor,
        title: Padding(
          padding: EdgeInsets.only(left: marginWidth16(context)),
          child: Text(
            textAlign: TextAlign.center,
            'Stumble!',
            style: GoogleFonts.sacramento(
              fontSize: MediaQuery.of(context).size.width / 13,
              color: headingColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
