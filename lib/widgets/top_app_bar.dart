import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../screens/filters_screen.dart';
import '../utils/internal_storage.dart';

enum DropdownOptions {
  filters,
  logout,
}

class DropdownOptionVal {
  final String value;
  final IconData icon;
  final DropdownOptions dropdownOption;

  DropdownOptionVal(this.value, this.icon, this.dropdownOption);
}

var defaultDropdownOptions = [
  DropdownOptionVal("Logout", Icons.exit_to_app, DropdownOptions.logout),
  DropdownOptionVal("Filters", Icons.filter_list, DropdownOptions.filters),
];

// ignore: must_be_immutable
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  String routeName;
  TopAppBar({required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height / 16,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: routeName != ""
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                // temporary solution until proper global state management is implemented
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(routeName),
              )
            : null,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              iconSize: MediaQuery.of(context).size.width / 14,
              enableFeedback: true,
              dropdownColor: backgroundColor,
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
                } else if (itemIdentifier == 'Filters') {
                  Navigator.pushNamed(context, FiltersScreen.routeName);
                }
              },
              icon: const Icon(
                Icons.menu,
                color: headingColor,
              ),
            ),
          ),
        ],
        backgroundColor: topAppBarColor,
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 16),
          child: Text(
            'Stumble!',
            style: GoogleFonts.sacramento(
              fontSize: MediaQuery.of(context).size.width / 14,
              color: headingColor,
              fontWeight: FontWeight.w900,
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
