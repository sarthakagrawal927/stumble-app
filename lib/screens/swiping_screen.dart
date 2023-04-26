import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/cards_stack_widget.dart';
import '../widgets/swipe_screen_background.dart';

class SwipingScreen extends StatefulWidget {
  static const routeName = '/swiping-screen';

  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 15, 15, 0.2),
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / 16,
        ),
        child: AppBar(
          leading: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 16),
              backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
            ),
            onPressed: () {
              Provider.of<Profile>(context, listen: false)
                  .setUndoListProfilesToFrontOfGetStumblesList();
            },
            child: const Icon(Icons.undo_rounded),
          ),
          backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 64),
            child: const Text(
              'Stumble!',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromRGBO(231, 10, 95, 1),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          const BackgroudCurveWidget(),
          CardsStackWidget(),
        ],
      ),
      bottomNavigationBar: const BottomBar(currentScreen: "SwipingScreen"),
    );
  }
}
