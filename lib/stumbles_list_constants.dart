import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';

enum DropDownOptions {
  liked,
  stumbledOntoMe,
  filters,
}

class DropdownOptionVals {
  final String label;
  final DropDownOptions value;
  final String blankScreenMessage;
  final Future<List<MiniProfile>> Function() getActivities;
  final Icon icon;
  final String routeName;

  DropdownOptionVals(this.label, this.value, this.blankScreenMessage,
      this.getActivities, this.icon, this.routeName);
}

final Map<DropDownOptions, DropdownOptionVals> dropDownOptions = {
  DropDownOptions.liked: DropdownOptionVals(
    'I stumbled into',
    DropDownOptions.liked,
    "Like someone",
    _getPeopleWhoLiked,
    const Icon(
      Icons.filter_list_rounded,
      color: Colors.white,
    ),
    '/i-stumbled-into-screen',
  ),
  DropDownOptions.stumbledOntoMe: DropdownOptionVals(
    'Stumbled onto me',
    DropDownOptions.stumbledOntoMe,
    "No stumblers yet!",
    _getPeopleWhoLikedMe,
    const Icon(
      Icons.favorite,
      color: Colors.white,
    ),
    '/stumbled-onto-me-screen',
  ),
  DropDownOptions.filters: DropdownOptionVals(
    'Filters',
    DropDownOptions.filters,
    "",
    _getFilters,
    const Icon(
      Icons.menu_book_outlined,
      color: Colors.white,
    ),
    '/filters-screen',
  ),
};

final dropDownOptionList = [
  dropDownOptions[DropDownOptions.liked],
  dropDownOptions[DropDownOptions.stumbledOntoMe],
  dropDownOptions[DropDownOptions.filters],
];

Future<List<MiniProfile>> _getPeopleWhoLiked() async {
  var profiles = await getPeopleILiked();
  return profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList();
}

Future<List<MiniProfile>> _getPeopleWhoLikedMe() async {
  var profiles = await getPeopleWhoLikedMe();
  return profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList();
}

Future<List<MiniProfile>> _getFilters() async {
  return <MiniProfile>[];
}

BoxDecoration imageBoxWidget(BuildContext context, MiniProfile profile) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.secondary,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(profile.photo ?? defaultBackupImage),
    ),
  );
}
