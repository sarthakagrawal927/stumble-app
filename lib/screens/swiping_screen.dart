import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:swipe_cards/swipe_cards.dart';

import '../providers/profiles.dart';
import '../widgets/bottom_app_bar.dart';

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
        backgroundColor: Theme.of(context).backgroundColor,
        title:  Text(
          'Dating, made better!',
          style: TextStyle(
            color: Theme.of(context).cardColor,
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
                          color: Theme.of(context).cardColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                _swipeItems[index].content.imageUrls[0]),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Text(
                                _swipeItems[index].content.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                _swipeItems[index].content.age.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              _swipeItems[index].content.isVerified
                                  ? const Icon(Icons.verified_sharp,
                                      color: Colors.blue)
                                  : const Icon(Icons.verified_outlined,
                                      color: Colors.white),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.question_mark_outlined),
                              ),
                            ],
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
      bottomNavigationBar: BottomBar(currentScreen: "SwipingScreen"),
    );
  }
}
