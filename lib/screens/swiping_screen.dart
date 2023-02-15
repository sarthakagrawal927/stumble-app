import 'package:dating_made_better/widgets/top_app_bar.dart';
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 28, 29, 1),
      key: _scaffoldKey,
      appBar: const TopAppBar(),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 16),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
                return ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                _swipeItems[index].content.imageUrls[0]),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 64),
                              child: Text(
                                _swipeItems[index].content.name + ", ",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 64),
                              child: Text(
                                _swipeItems[index]
                                    .content
                                    .age
                                    .toInt()
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            _swipeItems[index].content.isVerified
                                ? Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width / 64),
                                    child: const Icon(Icons.verified_sharp,
                                        color: Colors.blue),
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width / 64),
                                    child: const Icon(Icons.verified_outlined,
                                        color: Colors.white),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            'Talk to me about',
                            style: TextStyle(
                              color: Color.fromRGBO(237, 237, 237, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 32,
                          ),
                          const SingleChildScrollView(
                            child: Text(
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(237, 237, 237, 1),
                              ),
                              "f1; I'm a real nerd about it. I'm also into software, as you can see by these ginormous specs I'm wearing.",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                    )
                  ],
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentScreen: "SwipingScreen"),
    );
  }
}
