import 'package:dating_made_better/text_styles.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class TopAppBarWithScreensOption extends StatelessWidget
    implements PreferredSizeWidget {
  String routeName;
  TopAppBarWithScreensOption({required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        marginHeight16(context),
      ),
      child: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: topAppBarColor,
        title: Text(
            textAlign: TextAlign.center,
            'Your Stumblers',
            style: AppTextStyles.heading(context)),
      ),
    );
  }

  @override
  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
