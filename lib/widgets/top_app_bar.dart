import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../screens/filters_screen.dart';
import '../utils/internal_storage.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height / 16,
      ),
      child: AppBar(
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              dropdownColor: backgroundColor,
              items: const [
                DropdownMenuItem(
                  value: 'Filters',
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list_rounded,
                        color: whiteColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Filters',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: whiteColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Logout') {
                  deleteSecureData(authKey);
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
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 64),
          child: Text(
            'Stumble!',
            style: GoogleFonts.sacramento(
              fontSize: 35.0,
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
