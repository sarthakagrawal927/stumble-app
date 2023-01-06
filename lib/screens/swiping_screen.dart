import 'package:dating_made_better/screens/user_profile_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:swipe_cards/swipe_cards.dart';

import '../providers/profiles.dart';

class SwipingScreen extends StatefulWidget {
  static const routeName = '/swiping-screen';

  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    final userProfiles =
        Provider.of<Profiles>(context, listen: false).userProfiles;
    for (int i = 0; i < userProfiles.length; i++) {
      _swipeItems.add(
        SwipeItem(
          content: userProfiles[i],
          likeAction: () {},
          nopeAction: () {},
          superlikeAction: () {},
          onSlideUpdate: (region) async {
            // print("Region $region");
          },
        ),
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userProfiles = Provider.of<Profiles>(context).userProfiles;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Dating, made better!',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 220,
                  child: SwipeCards(
                    matchEngine: _matchEngine!,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                _swipeItems[index].content.imageUrl),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            _swipeItems[index].content.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      );
                    },
                    onStackFinished: () {},
                    itemChanged: (SwipeItem item, int index) {
                      // print( "item: ${item.content.name}, index: $index");
                      // content is an instance of profile
                    },
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.account_box_rounded),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, UserProfileScreen.routeName);
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                color: Colors.amber,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
