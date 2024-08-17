import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/screens/create_events_screen.dart';
import 'package:dating_made_better/widgets/dropdown_options_constants.dart';
import 'package:dating_made_better/widgets/top_app_bar_constants.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool centerTitle;
  DropDownType showActions;
  bool showLeading;
  String heading;
  GlobalKey dropDownKey;
  GlobalKey locationUsageKey;
  List<DropdownOptionVal?> dropDownItems;
  Screen screen;

  TopAppBar({
    required this.centerTitle,
    required this.showActions,
    required this.showLeading,
    required this.heading,
    this.dropDownKey = const GlobalObjectKey(""),
    this.locationUsageKey = const GlobalObjectKey(""),
    this.dropDownItems = const [],
    this.screen = Screen.swipingScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        marginHeight16(context),
      ),
      child: AppBar(
        leading: showLeading
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        actions: showActions == DropDownType.dropDown
            ? [
                DropDownButtonForAppBar(
                  dropDownItems: dropDownItems, dropDownKey: dropDownKey, screen: screen)
              ]
            : showActions == DropDownType.addItem
              ?
            [
              IconButton(icon: Icon(
                Icons.add_box_outlined, 
                color: AppColors.primaryColor,
                size: fontSize32(context),
              ), 
              onPressed: () { 
                  Navigator.of(context, rootNavigator: true).pushNamed(CreateEventScreen.routeName);
               },
              ),
            ] : null,
        title: screen == Screen.swipingScreen
            ? swipingScreenHeadingWithShowcase(
                context, locationUsageKey, heading)
            : showLeading
                ? Padding(
                    padding: EdgeInsets.only(left: marginWidth16(context)),
                    child: headingWidget(context, heading),
                  )
                : headingWidget(context, heading, screen: screen),
        backgroundColor: topAppBarColor,
      ),
    );
  }

  @override
  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class DropDownButtonForAppBar extends StatelessWidget {
  const DropDownButtonForAppBar({
    super.key,
    required this.dropDownItems,
    required this.dropDownKey,
    required this.screen,
  });

  final List<DropdownOptionVal?> dropDownItems;
  final GlobalKey<State<StatefulWidget>> dropDownKey;
  final Screen screen;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton(
        borderRadius: BorderRadius.circular(10),
        dropdownColor: AppColors.backgroundColor,
        iconSize: marginWidth16(context),
        items: getDropDownMenuList(context, dropDownItems),
        onChanged: (itemIdentifier) async {
          dropDownOptions[itemIdentifier]!.onClick(context);
        },
        icon: (dropDownButtonWithoutPadding(
            context, dropDownKey, screen)),
      ),
    ));
  }
}
