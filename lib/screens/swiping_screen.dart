import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:swipe_cards/swipe_cards.dart';

import '../providers/profiles.dart';
import '../widgets/ask_me_about_text_field.dart';
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
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SwipeCards(
                    matchEngine: _matchEngine!,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
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
                              Padding(
                                padding: const EdgeInsets.all(4.0),
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
                                padding: const EdgeInsets.all(4.0),
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
                                  ? const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.verified_sharp,
                                          color: Colors.blue),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.verified_outlined,
                                          color: Colors.white),
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
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.9, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Talk to me about',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color.fromRGBO(237, 237, 237, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
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
        ],
      ),
      bottomNavigationBar: BottomBar(currentScreen: "SwipingScreen"),
    );
  }
}
