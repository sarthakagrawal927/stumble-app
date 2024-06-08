import 'package:dating_made_better/text_styles.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  String heading;
  TopAppBar({required this.heading, super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        marginHeight16(context),
      ),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // temporary solution until proper global state management is implemented
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: const [],
        title: Padding(
          padding: EdgeInsets.only(left: marginWidth16(context)),
          child: Text(
            textAlign: TextAlign.center,
            heading,
            style: AppTextStyles.heading(context),
          ),
        ),
        backgroundColor: topAppBarColor,
      ),
    );
  }

  @override
  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
