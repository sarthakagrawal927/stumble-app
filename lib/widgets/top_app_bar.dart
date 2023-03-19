import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 16),
          backgroundColor: Theme.of(context).splashColor,
        ),
        onPressed: () {
          // Call location API here.
        },
        child: const Icon(Icons.navigation_sharp),
      ),
      actions: [
        DropdownButton(
          dropdownColor: const Color.fromRGBO(27, 18, 11, 1),
          items: [
            DropdownMenuItem(
              value: 'Filters',
              child: Container(
                child: Row(
                  children: const [
                    Icon(
                      Icons.filter_list_rounded,
                      color: Color.fromRGBO(237, 237, 237, 1),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Filters',
                      style: TextStyle(color: Color.fromRGBO(237, 237, 237, 1)),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'Logout',
              child: Container(
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Color.fromRGBO(237, 237, 237, 1),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(color: Color.fromRGBO(237, 237, 237, 1)),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'Logout') {
              FirebaseAuth.instance.signOut();
            } else if (itemIdentifier == 'Filters') {
              Navigator.pushNamed(context, FiltersScreen.routeName);
            }
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.white70,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).splashColor,
      title: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 64),
        child: const Text(
          'Stumble!',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
