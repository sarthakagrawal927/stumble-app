import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../../widgets/swipe_card.dart';
import '../../widgets/tag_swipe_card.dart';

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

  void handleActivityOnProfile([String? compliment]) {
    if (compliment != null) {
      swipeNotifier.value = Swipe.right;
    }
    if (swipeNotifier.value == Swipe.none) return;
    addActivityOnLike(widget.profile, swipeNotifier.value, compliment);
    widget.onSwipe(widget.profile);
    swipeNotifier.value = Swipe.none;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable<int>(
        // Data is the value this Draggable stores.
        data: widget.index,
        feedback: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder(
            valueListenable: swipeNotifier,
            builder: (context, swipe, _) {
              return RotationTransition(
                turns: swipe != Swipe.none
                    ? swipe == Swipe.left
                        ? const AlwaysStoppedAnimation(-15 / 360)
                        : const AlwaysStoppedAnimation(15 / 360)
                    : const AlwaysStoppedAnimation(0),
                child: Stack(
                  children: [
                    SwipeCard(
                      profile: widget.profile,
                      onSwipe: handleActivityOnProfile,
                    ),
                    swipe != Swipe.none
                        ? swipe == Swipe.right
                            ? Positioned(
                                top: 40,
                                left: 20,
                                child: Transform.rotate(
                                  angle: 12,
                                  child: TagWidgetForSwipeCards(
                                    text: 'LIKE',
                                    color: Colors.green[400]!,
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 50,
                                right: 24,
                                child: Transform.rotate(
                                  angle: -12,
                                  child: TagWidgetForSwipeCards(
                                    text: 'DISLIKE',
                                    color: Colors.red[400]!,
                                  ),
                                ),
                              )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
        onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
          // When Draggable widget is dragged right
          if (dragUpdateDetails.delta.dx > 0 &&
              dragUpdateDetails.globalPosition.dx >
                  MediaQuery.of(context).size.width / 2) {
            swipeNotifier.value = Swipe.right;
          }
          // When Draggable widget is dragged left
          if (dragUpdateDetails.delta.dx < 0 &&
              dragUpdateDetails.globalPosition.dx <
                  MediaQuery.of(context).size.width / 2) {
            swipeNotifier.value = Swipe.left;
          }
        },
        onDragEnd: (drag) {
          handleActivityOnProfile();
        },

        childWhenDragging: Container(
          color: Colors.transparent,
        ),

        child: SwipeCard(
            profile: widget.profile, onSwipe: handleActivityOnProfile),
      ),
    );
  }
}
