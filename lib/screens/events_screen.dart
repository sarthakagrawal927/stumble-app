import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/event.dart';
import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/bottom_app_bar.dart';
import 'package:dating_made_better/widgets/common/dialog_widget.dart';
import 'package:dating_made_better/widgets/common/small_profile_badge.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:dating_made_better/widgets/top_app_bar_constants.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  static const routeName = '/events-screen';

  @override
  State<EventsScreen> createState() => _EventsScreenState();
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setEventState(context));
  }


void setEventState(context) {
    _getEvents().then((value) {
      setState(() {
       listOfEvents = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        appBar: TopAppBar(
            centerTitle: false,
            showActions: DropDownType.addItem,
            showLeading: false,
            heading: "Events",
            screen: Screen.eventsScreen,
        ),
        body: listOfEvents.isNotEmpty
            ? GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listOfEvents.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: marginWidth128(context), top: marginHeight128(context), bottom: marginHeight128(context)),
                    child: GestureDetector(
                      onDoubleTap: () => DoNothingAction(),
                      onTap: () async {
                        dialogWidget(
                          context: context, 
                          submitLabel: "Register!", 
                          title: listOfEvents[index].eventName,
                          onSubmit: () async {
                            launchUrl(Uri.parse(listOfEvents[index].eventLink));
                          },
                          childWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: marginHeight4(context) * 1.25,
                                decoration: imageBoxWidget(
                                context, listOfEvents[index].eventImageUrl),),
                              SizedBox(height: marginHeight48(context)),
                              Text(
                                listOfEvents[index].eventDescription,
                                textAlign: TextAlign.left,
                                style: AppTextStyles.descriptionText(context, size: 12.5),
                              ),
                              SizedBox(height: marginHeight48(context)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                  const Icon(Icons.date_range, size: 25.0,),
                                  SizedBox(width: marginWidth128(context),),
                                  Text(style: AppTextStyles.descriptionText(context), listOfEvents[index].eventStartTime.substring(0, 10)),
                                ],),
                                SizedBox(width: marginWidth32(context),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  const Icon(Icons.timelapse, size: 25.0,),
                                  SizedBox(width: marginWidth128(context),),
                                  Text(style: AppTextStyles.descriptionText(context), "${listOfEvents[index].eventStartTime.substring(11, 16)} - ${listOfEvents[index].eventEndTime.substring(11, 16)}"),
                                ],)
                              ],),
                              SizedBox(height: marginHeight48(context)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                  const Icon(Icons.location_on, size: 25.0,),
                                  SizedBox(width: marginWidth128(context),),
                                  Text(style: AppTextStyles.descriptionText(context), listOfEvents[index].eventLocationName),
                                ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                  const Icon(Icons.people_sharp, size: 25.0,),
                                  SizedBox(width: marginWidth128(context),),
                                  Text(style: AppTextStyles.descriptionText(context), listOfEvents[index].numberOfInterestedUsersInEvent == null ? "0" : listOfEvents[index].numberOfInterestedUsersInEvent.toString(),),
                                ],),
                              ],),
                              SizedBox(height: marginHeight48(context)),
                              SmallProfileBadge(text: listOfEvents[index].eventOrganizerName, icon: Icons.person_pin_circle,),
                            ],
                          ),
                        );
                      },
                      child: Card(
                        borderOnForeground: true,
                        shape: BeveledRectangleBorder(),
                        elevation: 3,
                        child: Column(
                          children: [
                            Container(
                              height: marginHeight4(context) / 1.5,
                              width: MediaQuery.of(context).size.width / 1.1,
                              margin: EdgeInsets.all(marginHeight128(context)),
                              alignment: Alignment.bottomLeft,
                              decoration:
                                  imageBoxWidget(context, listOfEvents[index].eventImageUrl),
                            ),
                            SizedBox(height: marginHeight128(context)),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
                              child: Text(
                                listOfEvents[index].eventName, 
                                style: AppTextStyles.secondaryHeading(
                                  context, 
                                  color: AppColors.secondaryColor, 
                                  size: 15.0),
                              ),
                            ),
                            SizedBox(height: marginHeight128(context)),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
                              child: Text(
                                "${listOfEvents[index].eventDescription.substring(0,
                                min(listOfEvents[index].eventDescription.length, 75))}...",
                                textAlign: TextAlign.start,
                                style: AppTextStyles.regularText(context, size: 10.0),
                              ),
                            ),
                            SizedBox(height: marginHeight128(context)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(size: 25, Icons.people),
                                            const SizedBox(width: 10.0,),
                                            Text(
                                              style: AppTextStyles.descriptionText(context, size: 12.5),
                                              listOfEvents[index].numberOfInterestedUsersInEvent == null ? "0" : listOfEvents[index].numberOfInterestedUsersInEvent.toString()),
                                          ],
                                        ),
                                        Row(children: [ 
                                            CircleAvatar(
                                              maxRadius: 12.5,
                                              minRadius: 12.5,
                                              backgroundImage: CachedNetworkImageProvider(
                                                listOfEvents[index].eventOrganizerImage.isNotEmpty 
                                                ? listOfEvents[index].eventOrganizerImage 
                                                : defaultBackupImage,
                                                ),
                                              ),
                                            SizedBox(width: 10.0,),
                                            Text(
                                              style: AppTextStyles.descriptionText(context, size: 12.5),
                                              listOfEvents[index].eventOrganizerName, 
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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