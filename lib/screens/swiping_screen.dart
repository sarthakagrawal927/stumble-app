import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/cards_stack_widget.dart';
import '../widgets/swipe_screen_background.dart';

class SwipingScreen extends StatefulWidget {
  static const routeName = '/swiping-screen';

  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Future<String?> _setUserAuthToken() async {
    var authToken = await readSecureData(authKey);
    AppConstants.token = authToken ?? "";
    await getUserApi();
    return authToken;
  }

  @override
  void initState() {
    super.initState();
    _setUserAuthToken().then((token) {
      if (AppConstants.token.isEmpty) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> likedListOfProfiles =
        Provider.of<Profile>(context, listen: false).getLikedListOfProfiles();
    List<dynamic> stumbledOntoMeListOfProfiles =
        Provider.of<Profile>(context, listen: false)
            .getStumbledOntoMeListOfProfiles();

    BoxDecoration imageBoxWidget(BuildContext context, int index) {
      return BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(likedListOfProfiles[index].getFirstImageUrl.path),
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
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 16),
              backgroundColor: topAppBarColor,
            ),
            onPressed: () {
              Provider.of<Profile>(context, listen: false)
                  .setUndoListProfilesToFrontOfGetStumblesList();
            },
            child: Icon(
              Icons.undo_rounded,
              color: headingColor,
            ),
          ),
          actions: [
            DropdownButton(
              dropdownColor: topAppBarColor,
              items: [
                DropdownMenuItem(
                  value: 'I want to stumble into',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.filter_list_rounded,
                        color: whiteColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'I want to stumble into',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Stumbled onto me',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: whiteColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Stumbled onto me',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'I want to stumble into') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return likedListOfProfiles.isNotEmpty
                          ? Dialog(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                              child: GridView.builder(
                                itemCount: likedListOfProfiles.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Dialog(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        elevation: 16,
                                        child: Container(),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(
                                          MediaQuery.of(context).size.height /
                                              64),
                                      alignment: Alignment.bottomLeft,
                                      decoration:
                                          imageBoxWidget(context, index),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Dialog(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Keep stumbling!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  );
                } else if (itemIdentifier == 'Stumbled onto me') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return stumbledOntoMeListOfProfiles.isNotEmpty
                          ? Dialog(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                              child: GridView.builder(
                                itemCount: stumbledOntoMeListOfProfiles.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.all(
                                          MediaQuery.of(context).size.height /
                                              64),
                                      alignment: Alignment.bottomLeft,
                                      decoration:
                                          imageBoxWidget(context, index),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Dialog(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              elevation: 16,
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'We\'re certain your stumblers are on their way!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  );
                }
              },
              icon: Icon(
                Icons.menu,
                color: headingColor,
              ),
            ),
          ],
          backgroundColor: topAppBarColor,
          title: Text(
            textAlign: TextAlign.center,
            'Stumble!',
            style: TextStyle(
              fontSize: 25,
              color: headingColor,
            ),
          ),
        ),
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
