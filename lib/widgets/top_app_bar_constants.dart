import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/circle_avatar.dart';
import 'package:dating_made_better/widgets/common/info_dialog_widget.dart';
import 'package:dating_made_better/widgets/common/prompt_dialog.dart';
import 'package:dating_made_better/widgets/interest_types_constants.dart';
import 'package:dating_made_better/widgets/swipe_card.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

enum Screen {
  swipingScreen,
  userProfileOverviewScreen,
}

Icon dropdownMenuIcon(BuildContext context, {screen = Screen.swipingScreen}) {
  return Icon(
    Icons.menu,
    color: AppColors.primaryColor,
    size: fontSize32(context),
  );
}

Text headingWidget(BuildContext context, String heading,
    {screen = Screen.swipingScreen}) {
  return Text(
    textAlign: TextAlign.center,
    heading,
    style: AppTextStyles.heading(context),
  );
}

Container dropDownButtonWithoutPadding(
    BuildContext context, GlobalKey dropDownKey, Screen screen) {
  return Container(
      padding: EdgeInsets.only(right: marginWidth32(context)),
      child: screen == Screen.swipingScreen
          ? Showcase(
              description: "You can find your stumbler lists here!",
              key: dropDownKey,
              blurValue: 5,
              descriptionPadding: EdgeInsets.all(marginWidth128(context)),
              overlayOpacity: 0.1,
              showArrow: true,
              targetPadding: EdgeInsets.all(marginWidth128(context)),
              child: Transform.scale(
                  scale: 1.25, child: dropdownMenuIcon(context)))
          : Transform.scale(scale: 1.25, child: dropdownMenuIcon(context)));
}

Showcase swipingScreenHeadingWithShowcase(
    BuildContext context, GlobalKey locationUsageKey, String heading) {
  return Showcase(
      description: promptExplainingLocationUsage,
      descTextStyle: TextStyle(fontSize: marginWidth24(context)),
      key: locationUsageKey,
      blurValue: 5,
      descriptionPadding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 128,
        horizontal: marginWidth128(context),
      ),
      tooltipPosition: TooltipPosition.bottom,
      overlayOpacity: 0.5,
      showArrow: false,
      targetPadding: EdgeInsets.all(marginWidth32(context)),
      child: headingWidget(context, heading));
}

// ignore: must_be_immutable
class ChatScreenHeadingWithFiltersOption extends StatefulWidget {
  BuildContext context;
  int chatterId;
  String threadId;
  String displayPic;
  String name;
  bool profileLoading;
  bool showLookingForOption;
  bool lookingForSame;
  InterestType? lookingFor;

  ChatScreenHeadingWithFiltersOption(
      {required this.context,
      required this.chatterId,
      required this.threadId,
      required this.displayPic,
      required this.name,
      required this.profileLoading,
      required this.showLookingForOption,
      required this.lookingFor,
      required this.lookingForSame,
      super.key});

  @override
  State<ChatScreenHeadingWithFiltersOption> createState() =>
      _ChatScreenHeadingWithFiltersOptionState();
}

class _ChatScreenHeadingWithFiltersOptionState
    extends State<ChatScreenHeadingWithFiltersOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onDoubleTap: () => DoNothingAction(),
          onTap: () async {
            if (widget.profileLoading) return;
            widget.profileLoading = true;
            await getUserApi(widget.chatterId)
                .then((value) => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SwipeCard(
                          profile: value!,
                          isModalMode: true,
                        );
                      },
                    ));
            widget.profileLoading = false;
          },
          child: CircleAvatarWidget(marginWidth16(context), widget.displayPic),
        ),
        SizedBox(
          width: marginWidth128(context),
        ),
        Padding(
          padding: EdgeInsets.only(left: marginWidth64(context)),
          child: SizedBox(
              width: marginWidth4(context),
              child: Text(widget.name.split(" ").first,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.chatNameText(context))),
        ),
        const Spacer(),
        widget.showLookingForOption
            ? DropdownButtonHideUnderline(
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: AppColors.backgroundColor,
                  onTap: () async {
                    await showModelIfNotShown(
                        context, ModelOpened.userInterestInfoTeaching);
                  },
                  items: labelToInterest.entries
                      .map((e) => nicheSelectedOption(context, e.value))
                      .toList(),
                  onChanged: (itemIdentifier) async {
                    InterestType interest = labelToInterest[itemIdentifier]!;
                    updateUserInterest(
                            widget.threadId, interestValue[interest]!)
                        .then((sameInterest) {
                      if (sameInterest) {
                        setState(() {
                          widget.lookingForSame = true;
                          widget.lookingFor = interest;
                          widget.showLookingForOption = false;
                        });
                        promptDialog(
                          context,
                          promptExplainingStumblingReason,
                        );
                      } else {
                        setState(() {
                          widget.showLookingForOption = false;
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.visibility,
                    size: marginWidth12(context),
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

DropdownMenuItem<String> nicheSelectedOption(
    BuildContext context, InterestType selectedOption) {
  return DropdownMenuItem(
    value: interestToLabel[selectedOption],
    child: Text(
      interestToLabel[selectedOption]!,
      style: AppTextStyles.dropdownText(context),
    ),
  );
}
