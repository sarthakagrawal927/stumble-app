import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';

import '../providers/profile.dart';
import './draggable_swipe_card.dart';

Future<List<Profile>> _getStumbles() async {
  var profiles = await getPotentialStumblesApi();
  debugPrint(profiles.length.toString());
  return profiles.map<Profile>((e) => Profile.fromJson(e)).toList();
}

// ignore: must_be_immutable
class CardsStackWidget extends StatefulWidget with ChangeNotifier {
  CardsStackWidget({super.key});

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
}

class _CardsStackWidgetState extends State<CardsStackWidget>
    with SingleTickerProviderStateMixin {
  List<Profile> draggableItems = [];
  bool hasMore = true;

  fetchAndSetStumbles() {
    _getStumbles().then((values) {
      debugPrint(values.runtimeType.toString());
      if (mounted) {
        setState(() {
          draggableItems = [...draggableItems, ...values];
          hasMore = values.isNotEmpty;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetStumbles();
  }

  void removeProfileOnSwipe() async {
    setState(() {
      draggableItems.removeLast();
    });
    if (draggableItems.isEmpty && hasMore) {
      await fetchAndSetStumbles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        child: draggableItems.isEmpty
            ? Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: marginHeight8(context),
                    horizontal: marginWidth8(context),
                  ),
                  child: Text(
                      textAlign: TextAlign.center,
                      "No nearby stumblers to 'stumble' upon at the moment.",
                      style: AppTextStyles.regularText(context)),
                ),
              )
            : DragWidget(
                profile: draggableItems.last,
                onSwipe: removeProfileOnSwipe,
              ));
  }
}
