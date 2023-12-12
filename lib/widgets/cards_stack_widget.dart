import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    if (draggableItems.length < 2 && hasMore) {
      await fetchAndSetStumbles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              child: draggableItems.isEmpty
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 8,
                          horizontal: MediaQuery.of(context).size.width / 8,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          "No nearby stumblers to 'stumble' upon at the moment.",
                          style: GoogleFonts.sacramento(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    )
                  : DragWidget(
                      profile: draggableItems.last,
                      onSwipe: removeProfileOnSwipe,
                    )),
        ),
        Positioned(
          left: 0,
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
