import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

// ignore: must_be_immutable
class TopAppBarWithScreensOption extends StatelessWidget
    implements PreferredSizeWidget {
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
            child: Container(
              padding: EdgeInsets.zero,
              child: DropdownButton(
                padding: EdgeInsets.zero,
                iconSize: fontSize64(context),
                dropdownColor: dropDownColor,
                items: dropDownOptionList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e!.value,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            e.icon,
                            SizedBox(width: fontSize96(context)),
                            Container(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              child: Text(
                                e.label,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: fontSize64(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (itemIdentifier) async {
                  dropDownOptions[itemIdentifier]!.getActivities().then(
                        (value) => Navigator.pushNamed(
                            context, dropDownOptions[itemIdentifier]!.routeName,
                            arguments: value),
                      );
                },
                icon: Padding(
                  padding: EdgeInsets.only(right: marginWidth32(context)),
                  child: Icon(
                    Icons.menu,
                    color: headingColor,
                    size: fontSize32(context),
                  ),
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
              fontSize: fontSize28(context),
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
