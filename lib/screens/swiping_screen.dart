import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
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

  DropdownOptionVal(
      this.label, this.value, this.blankScreenMessage, this.getActivities);
}

final Map<DropDownOptions, DropdownOptionVal> dropDownOptions = {
  DropDownOptions.liked: DropdownOptionVal('I want to stumble into',
      DropDownOptions.liked, "Like someone", _getActivities),
  DropDownOptions.stumbledOntoMe: DropdownOptionVal('Stumbled onto me',
      DropDownOptions.stumbledOntoMe, "No one likes you", _getActivities2),
};

Future<List<MiniProfile>> _getActivities() async {
  var profiles = await getPeopleILiked();
  return profiles.map<MiniProfile>((e) => MiniProfile.fromJson(e)).toList();
}

Future<List<MiniProfile>> _getActivities2() async {
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
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration imageBoxWidget(BuildContext context, MiniProfile profile) {
      return BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(profile.photo ?? defaultBackupImage),
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
            leading: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 16),
                backgroundColor: topAppBarColor,
              ),
              onPressed: () {
                Provider.of<Profile>(context, listen: false)
                    .setUndoListProfilesToFrontOfGetStumblesList();
              },
              child: const Icon(
                Icons.undo_rounded,
                color: headingColor,
              ),
            ),
            actions: [
              DropdownButton(
                dropdownColor: topAppBarColor,
                items: [
                  DropdownMenuItem(
                    value: dropDownOptions[DropDownOptions.liked]!.value,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.filter_list_rounded,
                          color: whiteColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          dropDownOptions[DropDownOptions.liked]!.label,
                          style: const TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        dropDownOptions[DropDownOptions.stumbledOntoMe]!.value,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.exit_to_app,
                          color: whiteColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          dropDownOptions[DropDownOptions.stumbledOntoMe]!
                              .label,
                          style: const TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                ],
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
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
            ],
            backgroundColor: topAppBarColor,
            title: GestureDetector(
              onTap: () {
                deleteSecureData(authKey);
              },
              child: const Text(
                textAlign: TextAlign.center,
                'Stumble!',
                style: TextStyle(
                  fontSize: 25,
                  color: headingColor,
                ),
              ),
            )),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          const BackgroudCurveWidget(),
          CardsStackWidget(),
        ],
      ),
      bottomNavigationBar: const BottomBar(currentScreen: "SwipingScreen"),
    );
  }
}
