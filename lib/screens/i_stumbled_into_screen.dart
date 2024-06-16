import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

class IStumbledIntoScreen extends StatefulWidget {
  static const routeName = '/i-stumbled-into-screen';
  const IStumbledIntoScreen({super.key});

  @override
  State<IStumbledIntoScreen> createState() => _IStumbledIntoScreenState();
}

class _IStumbledIntoScreenState extends State<IStumbledIntoScreen> {
  @override
  Widget build(BuildContext context) {
    final List<MiniProfile> listOfProfiles =
        ModalRoute.of(context)!.settings.arguments as List<MiniProfile>;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: TopAppBar(
          centerTitle: true,
          showActions: false,
          showLeading: true,
          heading: "Stumble"),
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
                      decoration:
                          imageBoxWidget(context, listOfProfiles[index]),
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
                    getPromptTexts[PromptEnum.noLiked]!,
                    style: AppTextStyles.regularText(context)
                  ),
              )
            ));
  }
}
