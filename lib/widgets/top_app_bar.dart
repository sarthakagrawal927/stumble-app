import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        DropdownButton(
          items: [
            DropdownMenuItem(
              value: 'Logout',
              child: Container(
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'Logout') {
              FirebaseAuth.instance.signOut();
            }
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white70,
          ),
        )
      ],
      backgroundColor: Theme.of(context).splashColor,
      title: const Text(
        'Stumble!',
        style: TextStyle(
          fontSize: 25,
          color: Colors.white70,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
