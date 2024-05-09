import 'dart:async';

import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/inherited_keys_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../../widgets/swipe_card.dart';

Future<void> addActivityOnLike(
    Profile profile, ActivityType activity, int timeTaken,
    [String? comment]) {
  Map<String, dynamic> bodyParams = {
    'targetId': profile.id,
    'type': activityValue[activity],
    'compliment': comment ?? '',
    'timeTaken': timeTaken,
  };
  return addActivityOnProfileApi(bodyParams);
}

class DragWidget extends StatefulWidget {
  const DragWidget({
    super.key,
    required this.profile,
    required this.onSwipe,
  });
  final Profile profile;

  final Function onSwipe;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  Future<void> handleActivityOnProfile(ActivityType activity,
      [String? compliment]) async {
    int elapsedTime = timer.elapsedMilliseconds;
    await addActivityOnLike(widget.profile, activity, elapsedTime, compliment);
    await widget.onSwipe(); // fetches profiles
  }

  final timer = Stopwatch();

  @override
  void dispose() {
    timer.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    timer.reset();
    timer.start();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Showcase(
            description: "Leave a comment to stumble!",
            key: InheritedKeysHelper.of(context).profileLikeKey,
            blurValue: 5,
            tooltipPosition: TooltipPosition.top,
            descriptionPadding:
                EdgeInsets.all(MediaQuery.of(context).size.width / 128),
            overlayOpacity: 0.1,
            showArrow: true,
            child: SwipeCard(
              profile: widget.profile,
              onSwipe: handleActivityOnProfile,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 24,
            left: 0,
            child: Showcase(
              description: "Click this if uninterested in conversation.",
              key: InheritedKeysHelper.of(context).profileDislikeKey,
              blurValue: 5,
              descriptionPadding:
                  EdgeInsets.all(MediaQuery.of(context).size.width / 128),
              overlayOpacity: 0.1,
              showArrow: true,
              targetPadding:
                  EdgeInsets.all(MediaQuery.of(context).size.width / 128),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(eccentricity: 0.0),
                    alignment: Alignment.bottomLeft,
                    backgroundColor: backgroundColor),
                onPressed: () async {
                  await handleActivityOnProfile(
                    ActivityType.dislike,
                  );
                },
                child: Icon(Icons.cancel,
                    color: Colors.black87,
                    size: MediaQuery.of(context).size.width / 6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
