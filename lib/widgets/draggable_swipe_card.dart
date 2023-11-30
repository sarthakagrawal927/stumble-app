import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../../widgets/swipe_card.dart';

Future<void> addActivityOnLike(Profile profile, Swipe action,
    [String? comment]) {
  Map<String, dynamic> bodyParams = {
    'targetId': profile.id,
    'type': action == Swipe.right
        ? activityValue[ActivityType.like]
        : activityValue[ActivityType.dislike],
    'compliment': comment ?? '',
  };
  return addActivityOnProfileApi(bodyParams);
}

class DragWidget extends StatefulWidget {
  const DragWidget({
    super.key,
    required this.profile,
    required this.index,
    required this.swipeNotifier,
    required this.onSwipe,
  });
  final Profile profile;
  final int index;
  final ValueNotifier<Swipe> swipeNotifier;
  final Function onSwipe;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  void handleActivityOnProfile([String? compliment, bool? leftSwipeClicked]) {
    if (compliment != null) {
      swipeNotifier.value = Swipe.right;
    }
    if (leftSwipeClicked == true) {
      swipeNotifier.value = Swipe.left;
    }
    if (swipeNotifier.value == Swipe.none) return;
    addActivityOnLike(widget.profile, swipeNotifier.value, compliment);
    widget.onSwipe(widget.profile);
    swipeNotifier.value = Swipe.none;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SwipeCard(profile: widget.profile, onSwipe: handleActivityOnProfile),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 12,
            left: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(eccentricity: 0.0),
                  alignment: Alignment.bottomLeft,
                  backgroundColor: backgroundColor),
              onPressed: () {
                handleActivityOnProfile(null, true);
              },
              child: Icon(Icons.cancel,
                  size: MediaQuery.of(context).size.width / 6),
            ),
          ),
        ],
      ),
    );
  }
}
