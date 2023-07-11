import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../screens/filters_screen.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height / 16,
      ),
      child: AppBar(
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 16),
            backgroundColor: topAppBarColor,
          ),
          onPressed: () {
            // Call location API here.
          },
          child: Icon(
            Icons.navigation_sharp,
            color: headingColor,
          ),
        ),
        actions: [
          DropdownButton(
            dropdownColor: backgroundColor,
            items: [
              DropdownMenuItem(
                value: 'Filters',
                child: Row(
                  children: const [
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
                  children: const [
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
                var logger = Logger();
                logger.i("Need to add Logout mechanism here.");
              } else if (itemIdentifier == 'Filters') {
                Navigator.pushNamed(context, FiltersScreen.routeName);
              }
            },
            icon: Icon(
              Icons.menu,
              color: topAppBarColor,
            ),
          ),
        ],
        backgroundColor: topAppBarColor,
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 64),
          child: Text(
            'Stumble!',
            style: TextStyle(
              fontSize: 25,
              color: headingColor,
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
