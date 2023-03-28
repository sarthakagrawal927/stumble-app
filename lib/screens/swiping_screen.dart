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
      backgroundColor: const Color.fromRGBO(26, 28, 29, 1),
      key: _scaffoldKey,
      appBar: const TopAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 16,
          right: MediaQuery.of(context).size.width / 16,
          top: MediaQuery.of(context).size.height / 32,
          bottom: MediaQuery.of(context).size.height / 32,
        ),
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
                        alignment: Alignment.bottomRight,
                        decoration: imageBoxWidget(context, index),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 32),
                              child: Text(
                                _swipeItems[index].content.name + ", ",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              "${_swipeItems[index].content.age.toInt()} ",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            _swipeItems[index].content.isVerified
                                ? const Icon(Icons.verified_sharp,
                                    color: Colors.blue)
                                : const Icon(Icons.verified_outlined,
                                    color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromRGBO(26, 28, 29, 1),
                      height: MediaQuery.of(context).size.height / 32,
                    ),
                    Container(
                      color: const Color.fromRGBO(26, 28, 29, 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 32,
                            child: const Text(
                              'Talk to me about',
                              style: TextStyle(
                                color: Color.fromRGBO(237, 237, 237, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 32,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                            child: const SingleChildScrollView(
                              child: Text(
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(237, 237, 237, 1),
                                ),
                                "f1; I'm a real nerd about it. I'm also into software, as you can see by these ginormous specs I'm wearing.",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 16,
                      color: const Color.fromRGBO(26, 28, 29, 1),
                    ),
                    Container(
                      color: const Color.fromRGBO(26, 28, 29, 1),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Container(
                          alignment: Alignment.bottomLeft,
                          decoration: imageBoxWidget(context, 1)),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 16,
                      color: const Color.fromRGBO(26, 28, 29, 1),
                    ),
                    Container(
                      color: const Color.fromRGBO(26, 28, 29, 1),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Container(
                          alignment: Alignment.bottomLeft,
                          decoration: imageBoxWidget(context, 2)),
                    ),
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

  BoxDecoration imageBoxWidget(BuildContext context, int index) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(_swipeItems[index].content.imageUrls[0].path),
      ),
    );
  }
}
