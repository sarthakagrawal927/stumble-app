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
            "Do you want to have the non-platonic filters enabled?"),
        Consumer<Profile>(
          builder: (context, value, child) => Card(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 16,
              top: MediaQuery.of(context).size.height / 6,
            ),
            color: Colors.transparent,
            child: CheckboxListTile(
              title: const Text(
                'Non-platonic filters: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
        ScreenGoToNextPageRow("You will not be shown the dating filters.", "",
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
