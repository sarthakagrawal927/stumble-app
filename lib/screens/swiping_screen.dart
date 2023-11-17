import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/cards_stack_widget.dart';
import '../widgets/swipe_screen_background.dart';

enum DropDownOptions {
  liked,
  stumbledOntoMe,
}

class DropdownOptionVal {
  final String label;
  final DropDownOptions value;
  final String blankScreenMessage;
  final Future<List<MiniProfile>> Function() getActivities;
  final Icon icon;

  DropdownOptionVal(this.label, this.value, this.blankScreenMessage,
      this.getActivities, this.icon);
}

final Map<DropDownOptions, DropdownOptionVal> dropDownOptions = {
  DropDownOptions.liked: DropdownOptionVal(
      'I wanna stumble into',
      DropDownOptions.liked,
      "Like someone",
      _getPeopleWhoLiked,
      const Icon(
        Icons.filter_list_rounded,
        color: Colors.white,
      )),
  DropDownOptions.stumbledOntoMe: DropdownOptionVal(
      'Stumbled onto me',
      DropDownOptions.stumbledOntoMe,
      "No stumblers yet!",
      _getPeopleWhoLikedMe,
      const Icon(
        Icons.favorite,
        color: Colors.white,
      )),
};

final dropDownOptionList = [
  dropDownOptions[DropDownOptions.liked],
  dropDownOptions[DropDownOptions.stumbledOntoMe],
];

Future<List<MiniProfile>> _getPeopleWhoLiked() async {
  var profiles = await getPeopleILiked();
  return profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList();
}

Future<List<MiniProfile>> _getPeopleWhoLikedMe() async {
  var profiles = await getPeopleWhoLikedMe();
  return profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList();
}

class SwipingScreen extends StatefulWidget {
  static const routeName = '/swiping-screen';

  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<Profile>(context, listen: false).setEntireProfileForEdit();
    });
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration imageBoxWidget(BuildContext context, MiniProfile profile) {
      return BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        image: DecorationImage(
          fit: BoxFit.cover,
          image:
              CachedNetworkImageProvider(profile.photo ?? defaultBackupImage),
        ),
      );
    }

    return Scaffold(
      backgroundColor: widgetColor,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / 16,
        ),
        child: AppBar(
            actions: [
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  iconSize: MediaQuery.of(context).size.width / 14,
                  dropdownColor: topAppBarColor,
                  items: dropDownOptionList
                      .map((e) => DropdownMenuItem(
                            alignment: Alignment.center,
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
                          ))
                      .toList(),
                  onChanged: (itemIdentifier) async {
                    dropDownOptions[itemIdentifier]!
                        .getActivities()
                        .then((value) => showDialog(
                              context: context,
                              builder: (context) {
                                return value.isNotEmpty
                                    ? Dialog(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        elevation: 16,
                                        child: GridView.builder(
                                          itemCount: value.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Dialog(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  elevation: 16,
                                                  child: Container(),
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        64),
                                                alignment: Alignment.bottomLeft,
                                                decoration: imageBoxWidget(
                                                    context, value[index]),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Dialog(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        elevation: 16,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              dropDownOptions[itemIdentifier]!
                                                  .blankScreenMessage,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            ));
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: headingColor,
                  ),
                ),
              ),
            ],
            backgroundColor: topAppBarColor,
            title: Text(
              textAlign: TextAlign.center,
              'Stumble!',
              style: GoogleFonts.sacramento(
                fontSize: MediaQuery.of(context).size.width / 14,
                color: headingColor,
                fontWeight: FontWeight.w900,
              ),
            )),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          const BackgroundCurveWidget(),
          CardsStackWidget(),
          const MyLocationComponent(),
        ],
      ),
      bottomNavigationBar:
          const BottomBar(currentScreen: BottomBarScreens.swipingScreen),
    );
  }
}
