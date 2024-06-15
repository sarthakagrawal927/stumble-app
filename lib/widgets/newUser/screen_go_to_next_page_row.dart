import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:flutter/material.dart';

class ScreenGoToNextPageRow extends StatelessWidget {
  const ScreenGoToNextPageRow(
      this.functionToSetData,
      {super.key});
  final Function functionToSetData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,

        child: Container(
          margin: EdgeInsets.only(bottom: marginHeight32(context)),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.double_arrow_sharp),
            color: AppColors.backgroundColor,
            iconSize: fontSize24(context),
            onPressed: (() async {
            await functionToSetData();
          }),
          ),
        ),
      ),
    );
  }
}
