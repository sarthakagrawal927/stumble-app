import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';
import '../newUser/screen_heading_widget.dart';
import '../newUser/screen_go_to_next_page_row.dart';

// ignore: must_be_immutable
class NameColumn extends StatefulWidget {
  Size deviceSize;
  NameColumn(this.deviceSize, {super.key});

  @override
  State<NameColumn> createState() => _NameColumnState();
}

class _NameColumnState extends State<NameColumn> {
  final nameTextBoxController =
      TextEditingController(text: AppConstants.nameFromAppleAuth);

  @override
  void dispose() {
    nameTextBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("What should your 'stumblers' call you?"),
        Container(
          margin: EdgeInsets.only(
            left: marginWidth16(context),
            right: marginWidth16(context),
          ),
          padding: EdgeInsets.symmetric(
            vertical: marginHeight32(context),
            horizontal: marginWidth16(context),
          ),
          child: Text(
              style: TextStyle(
                fontSize: fontSize48(context),
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.w400,
              ),
              "You won't be able to change this later!"),
        ),
        Container(
          margin: EdgeInsets.only(
            left: marginWidth16(context),
            right: marginWidth16(context),
          ),
          padding: EdgeInsets.only(top: marginHeight32(context)),
          child: TextField(
            controller: nameTextBoxController,
            cursorColor: AppColors.backgroundColor,
            style: TextStyle(
              color: whiteColor,
              fontSize: fontSize32(context),
            ),
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.backgroundColor,
                )),
                labelText: 'Name',
                labelStyle: AppTextStyles.regularText(context,
                    color: AppColors.backgroundColor)),
            keyboardType: TextInputType.name,
            autofocus: true,
          ),
        ),
        ScreenGoToNextPageRow(
          () {
            handleSnackBarIfInputNotFilled(
                nameTextBoxController.value.text != "", () async {
              Provider.of<FirstScreenStateProviders>(context, listen: false)
                  .setNextScreenActive();
              Provider.of<Profile>(context, listen: false).setName =
                  nameTextBoxController.value.text;
            }, context, valueToFill: "name");
          },
        )
      ],
    );
  }
}
