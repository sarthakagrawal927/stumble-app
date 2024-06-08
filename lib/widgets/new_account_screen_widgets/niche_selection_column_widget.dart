import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/widgets/newUser/screen_go_to_next_page_row.dart';
import 'package:dating_made_better/widgets/newUser/screen_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NicheSelectionColumn extends StatefulWidget {
  Size deviceSize;
  NicheSelectionColumn(this.deviceSize, {super.key});

  @override
  State<NicheSelectionColumn> createState() => _NicheSelectionColumnState();
}

class _NicheSelectionColumnState extends State<NicheSelectionColumn> {
  bool isUserPlatonic = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ScreenHeadingWidget(
            "Do you want to have the Stumbling filters enabled?"),
        Container(
          color: Colors.black38,
          margin: EdgeInsets.symmetric(
            horizontal: marginWidth16(context),
          ),
        child: Padding(
            padding: EdgeInsets.symmetric(
            vertical: marginHeight64(context),
            horizontal: marginWidth64(context),
          ),
          child: Text(
              textAlign: TextAlign.center,
              "Our objective is to diminish the hurdles that impede individuals from stumbling upon remarkable people. We strive to offer clarity regarding the intentions of those they encounter—whether for a friendly chat, professional networking, or romantic interest. To facilitate this, we've introduced an option enabling users to specify their desired connection with each new encounter. Only when *both* parties stumble upon the same option will it be revealed to both!", 
            style: TextStyle(
              color: whiteColor,
              fontSize: fontSize48(context)
            ),
            ),
        ),
        ),
        Consumer<Profile>(
          builder: (context, value, child) => Card(
            margin: EdgeInsets.only(
              left: marginWidth16(context),
              right: marginWidth16(context),
              top: marginHeight32(context),
            ),
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(unselectedWidgetColor: whiteColor),
              child: CheckboxListTile(
                title: Text(
                  'Stumbling filters: ',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: fontSize32(context),
                  ),
                ),
                value: isUserPlatonic,
                onChanged: (_) {
                  setState(() {
                    isUserPlatonic = !isUserPlatonic;
                  });
                },
              ),
            ),
          ),
        ),
        ScreenGoToNextPageRow("Know stumbling reasons for all!", "",
            () {
          Provider.of<FirstScreenStateProviders>(context, listen: false)
              .setNextScreenActive();
          Provider.of<Profile>(context, listen: false).setIfUserIsPlatonic =
              isUserPlatonic;
        }),
      ],
    );
  }
}
