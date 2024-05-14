import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../screens/filters_screen.dart';
import '../utils/internal_storage.dart';

enum DropdownOptions {
  filters,
  logout,
  delete,
}

class DropdownOptionVal {
  final String value;
  final IconData icon;
  final DropdownOptions dropdownOption;

  DropdownOptionVal(this.value, this.icon, this.dropdownOption);
}

var defaultDropdownOptions = [
  DropdownOptionVal("Filters", Icons.filter_list, DropdownOptions.filters),
  DropdownOptionVal("Logout", Icons.exit_to_app, DropdownOptions.logout),
  DropdownOptionVal("Delete :'(", Icons.emoji_flags, DropdownOptions.delete),
];

// ignore: must_be_immutable
class TopAppBarWithLogoutOption extends StatelessWidget implements PreferredSizeWidget {
  String routeName;
  TopAppBarWithLogoutOption({required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
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
                } else if (itemIdentifier == 'Delete :\'(') {
                  deleteUserApi().then((_) => deleteSecureData(authKey).then((value) {
                    Provider.of<FirstScreenStateProviders>(context,
                            listen: false)
                        .setActiveScreenMode(ScreenMode.landing);
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  }));
                } else if (itemIdentifier == 'Filters') {
                  Navigator.pushNamed(context, FiltersScreen.routeName);
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
