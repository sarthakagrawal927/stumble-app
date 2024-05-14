import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../screens/filters_screen.dart';
import '../utils/internal_storage.dart';

// ignore: must_be_immutable
class TopAppBarWithScreensOption extends StatelessWidget implements PreferredSizeWidget {
  String routeName;
  TopAppBarWithScreensOption({required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        marginHeight16(context),
      ),
      child: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              iconSize: marginWidth16(context),
              dropdownColor: dropDownColor,
              items: dropDownOptionList
                  .map((e) => DropdownMenuItem(
                        value: e!.value,
                        child: Row(
                              children: [
                                e.icon,
                                const SizedBox(width: 8),
                                Text(
                                  e.label,
                                  style: const TextStyle(
                                    color: whiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                      ),
                    )
                  .toList(),
              onChanged: (itemIdentifier) async {
                  dropDownOptions[itemIdentifier]!.getActivities().then(
                        (value) => Navigator.pushNamed(context,
                            dropDownOptions[itemIdentifier]!.routeName,
                            arguments: value),
                      );
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
