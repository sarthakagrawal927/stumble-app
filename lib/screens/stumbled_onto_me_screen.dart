import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StumbledOntoMeScreen extends StatefulWidget {
  static const routeName = '/stumbled-onto-me-screen';
  const StumbledOntoMeScreen({super.key});

  @override
  State<StumbledOntoMeScreen> createState() => _StumbledOntoMeScreenState();
}

class _StumbledOntoMeScreenState extends State<StumbledOntoMeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<MiniProfile> listOfProfiles =
        ModalRoute.of(context)!.settings.arguments as List<MiniProfile>;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: TopAppBar(
        routeName: SwipingScreen.routeName,
      ),
      body: listOfProfiles.isNotEmpty
          ? GridView.builder(
              itemCount: listOfProfiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onDoubleTap: () => DoNothingAction(),
                  onTap: () async {
                    Profile profile;
                    profile = await getUserApi(listOfProfiles[index].id)
                        .then((value) => profile = value!);

                    // ignore: use_build_context_synchronously
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SwipeCard(
                          profile: profile,
                          isModalMode: true,
                        );
                      },
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 64),
                    alignment: Alignment.bottomLeft,
                    decoration: imageBoxWidget(context, listOfProfiles[index]),
                  ),
                );
              },
            )
          : Text(
              textAlign: TextAlign.center,
              "No nearby stumblers to 'stumble' upon at the moment.",
              style: GoogleFonts.sacramento(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
    );
  }
}
