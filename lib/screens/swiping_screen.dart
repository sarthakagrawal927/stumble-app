import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:swipe_cards/swipe_cards.dart';

import '../providers/profiles.dart';

class SwipingScreen extends StatefulWidget {
  static const routeName = '/swiping-screen';

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
            print("Region $region");
          },
        ),
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    final userProfiles = Provider.of<Profiles>(context).userProfiles;
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: SwipeCards(
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              NetworkImage(_swipeItems[index].content.imageUrl),
                        ),
                      ),
                      child: Text(
                        _swipeItems[index].content.name,
                        style: TextStyle(fontSize: 100),
                      ),
                    );
                  },
                  onStackFinished: () {},
                  itemChanged: (SwipeItem item, int index) {
                    print("item: ${item.content.text}, index: $index");
                  },
                  upSwipeAllowed: true,
                  fillSpace: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
