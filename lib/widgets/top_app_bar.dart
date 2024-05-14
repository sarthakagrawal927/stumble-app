import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

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
  String heading;
  TopAppBar({required this.routeName, required this.heading, super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        marginHeight16(context),
      ),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // temporary solution until proper global state management is implemented
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: const [],
        title: Padding(
          padding: EdgeInsets.only(left: marginWidth16(context)),
          child: Text(
            textAlign: TextAlign.center,
            heading,
            style: GoogleFonts.sacramento(
              fontSize: MediaQuery.of(context).size.width / 13,
              color: headingColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: topAppBarColor,
      ),
    );
  }

  @override
  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
