import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: AppColors.backgroundColor,
      appBar: TopAppBar(heading: "Stumble"),
      body: listOfProfiles.isNotEmpty
          ? GridView.builder(
              itemCount: listOfProfiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onDoubleTap: () => DoNothingAction(),
                  onTap: () async {
                    getUserApi(listOfProfiles[index].id)
                        .then((value) => showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SwipeCard(
                                  profile: value!,
                                  isModalMode: true,
                                );
                              },
                            ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(marginHeight64(context)),
                    alignment: Alignment.bottomLeft,
                    decoration: imageBoxWidget(context, listOfProfiles[index]),
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
                    "No nearby stumblers to 'stumble' upon at the moment.",
                    style: AppTextStyles.regularText(context)),
              ),
            ),
    );
  }
}
