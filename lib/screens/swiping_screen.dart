import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: const Color.fromRGBO(15, 15, 15, 0.2),
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
              backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
            ),
            onPressed: () {
              Provider.of<Profile>(context, listen: false)
                  .setUndoListProfilesToFrontOfGetStumblesList();
            },
            child: const Icon(Icons.undo_rounded),
          ),
          actions: [
            DropdownButton(
              dropdownColor: const Color.fromRGBO(15, 15, 15, 1),
              items: [
                DropdownMenuItem(
                  value: 'I want to stumble into',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.filter_list_rounded,
                        color: Color.fromRGBO(237, 237, 237, 1),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'I want to stumble into',
                        style:
                            TextStyle(color: Color.fromRGBO(237, 237, 237, 1)),
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
                        color: Color.fromRGBO(237, 237, 237, 1),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Stumbled onto me',
                        style:
                            TextStyle(color: Color.fromRGBO(237, 237, 237, 1)),
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
                                  return Container(
                                    margin: EdgeInsets.all(
                                        MediaQuery.of(context).size.height /
                                            64),
                                    alignment: Alignment.bottomLeft,
                                    decoration: imageBoxWidget(context, index),
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
                                  return Container(
                                    margin: EdgeInsets.all(
                                        MediaQuery.of(context).size.height /
                                            64),
                                    alignment: Alignment.bottomLeft,
                                    decoration: imageBoxWidget(context, index),
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
              icon: const Icon(
                Icons.menu,
                color: Color.fromRGBO(231, 10, 95, 1),
              ),
            ),
          ],
          backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
          title: const Text(
            textAlign: TextAlign.center,
            'Stumble!',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromRGBO(231, 10, 95, 1),
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
