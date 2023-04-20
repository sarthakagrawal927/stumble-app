import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../providers/profile.dart';
import '../providers/profiles.dart';

class SwipeItemsList extends ChangeNotifier {
  List<SwipeItem> getSwipeItems(BuildContext context) {
    List<SwipeItem> swipeItemsList = [];
    List<Profile> currentListOfStumbles =
        Provider.of<Profiles>(context).getCurrentListOfCachedStumbles;
    for (int i = 0; i < currentListOfStumbles.length; i++) {
      swipeItemsList.add(
        SwipeItem(
          content: currentListOfStumbles[i],
          likeAction: () {
            Provider.of<Profiles>(context).removeLikedProfiles(i);
          },
          nopeAction: () {
            Provider.of<Profiles>(context).setUndoListOfProfiles =
                currentListOfStumbles[i];
          },
          superlikeAction: () {},
          onSlideUpdate: (region) async {
            // print("Region $region");
          },
        ),
      );
    }
    return swipeItemsList;
  }
}
