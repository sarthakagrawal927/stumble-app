import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:dating_made_better/widgets/generic_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DropdownOptionVal {
  final String value;
  final IconData? icon;
  final Function(BuildContext context) onClick;

  DropdownOptionVal(
    this.value,
    this.icon,
    this.onClick,
  );
}

class DropdownOptionParams {
  final String value;
  final IconData? icon;
  final Function() onClick;

  DropdownOptionParams({
    required this.value,
    required this.onClick,
    this.icon,
  });
}

final Map<String, DropdownOptionVal?> dropDownOptions = {
  'I stumbled into': DropdownOptionVal(
    'I stumbled into',
    Icons.filter_list_rounded,
    ((context) => _getPeopleWhoLiked().then((value) => Navigator.pushNamed(
        context, "/i-stumbled-into-screen",
        arguments: value))),
  ),
  'Stumbled onto me': DropdownOptionVal(
    'Stumbled onto me',
    Icons.favorite,
    ((context) => _getPeopleWhoLikedMe().then((value) => Navigator.pushNamed(
        context, "/stumbled-onto-me-screen",
        arguments: value))),
  ),
  'Filters': DropdownOptionVal(
    'Filters',
    Icons.menu_book_outlined,
    ((context) => Navigator.pushNamed(context, "/filters-screen")),
  ),
  'Leave feedback!': DropdownOptionVal(
      'Leave feedback!',
      Icons.pages,
      ((context) =>
          genericDialogWidget(context, reason: PromptReason.appFeedback))),
  'Privacy terms': DropdownOptionVal(
    'Privacy terms',
    Icons.document_scanner,
    (context) => launchUrl(Uri.parse('https://www.getstumble.app/privacy')),
  ),
  'Logout': DropdownOptionVal(
      'Logout',
      Icons.exit_to_app,
      ((context) => deleteSecureData(authKey).then((value) {
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setActiveScreenMode(ScreenMode.landing);
            Navigator.pushReplacementNamed(context, AuthScreen.routeName);
          }))),
  'Delete :\'(': DropdownOptionVal(
    'Delete :\'(',
    Icons.emoji_flags,
    ((context) =>
        genericDialogWidget(context, reason: PromptReason.deletionPrompt)),
  ),
  'Block': DropdownOptionVal('Block', Icons.block, ((context, [chatterId]) {
    blockUserApi(chatterId);
    Navigator.of(context, rootNavigator: true)
        .pushReplacementNamed(MatchesAndChatsScreen.routeName);
  })),
  'Report': DropdownOptionVal('Report', Icons.report, (((context, [chatterId]) {
    genericDialogWidget(context,
        reason: PromptReason.reportUser, chatterId: chatterId);
  }))),
};

final dropdownWithScreenOptions = [
  dropDownOptions['I stumbled into'],
  dropDownOptions['Stumbled onto me'],
  dropDownOptions['Filters'],
];

final profileScreensDropdownOptions = [
  dropDownOptions['Leave feedback!'],
  dropDownOptions['Privacy terms'],
  dropDownOptions['Logout'],
  dropDownOptions['Delete :\'('],
];

final individualChatScreenDropdownOptions = [
  dropDownOptions['Block'],
  dropDownOptions['Report'],
];

List<DropdownMenuItem<Object>>? getDropDownMenuList(
    BuildContext context, List<DropdownOptionVal?> dropdownOptionsList) {
  return dropdownOptionsList
      .map((e) => DropdownMenuItem(
            value: e!.value,
            child: Row(
              children: [
                Icon(e.icon, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(e.value, style: AppTextStyles.dropdownText(context)),
              ],
            ),
          ))
      .toList();
}

Future<List<MiniProfile>> _getPeopleWhoLiked() async {
  var profiles = await getPeopleILiked();
  return profiles.isNotEmpty
      ? profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList()
      : <MiniProfile>[];
}

Future<List<MiniProfile>> _getPeopleWhoLikedMe() async {
  var profiles = await getPeopleWhoLikedMe();
  return profiles.isNotEmpty
      ? profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList()
      : <MiniProfile>[];
}
