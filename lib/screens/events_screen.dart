import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/event.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/bottom_app_bar.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:dating_made_better/widgets/top_app_bar_constants.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  static const routeName = '/events-screen';

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

List<Event> getEventsFromBackend() {
  List<Event> listOfEvents = [];
  _getEvents().then((value) => listOfEvents = value);
  return listOfEvents;
}

Future<List<Event>> _getEvents() async {
  var events = await getEvents();
  return events.isNotEmpty
      ? events.map<Event>((e) => Event.fromJson(e)).toList()
      : <Event>[];
}


class _EventsScreenState extends State<EventsScreen> {
  List<Event> listOfEvents = [];
  @override
  Widget build(BuildContext context) {
    final List<Event> listOfEvents = getEventsFromBackend();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        appBar: TopAppBar(
            centerTitle: false,
            showActions: true,
            showLeading: false,
            heading: "Events",
            screen: Screen.eventsScreen,
        ),
        body: listOfEvents.isNotEmpty
            ? GridView.builder(
                itemCount: listOfEvents.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onDoubleTap: () => DoNothingAction(),
                    onTap: () async {},
                    child: Container(),
                  );
                },
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: marginWidth32(context),
                  vertical: marginHeight64(context),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                      textAlign: TextAlign.center,
                      getPromptTexts[PromptEnum.noEvents]!,
                      style: AppTextStyles.regularText(context)),
                ),
              ),
        bottomNavigationBar:
            const BottomBar(currentScreen: BottomBarScreens.eventsScreen),
    );
  }
}