import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/widgets/comment_feature_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';

class SwipeCard extends StatelessWidget {
  const SwipeCard({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        shrinkWrap: true,
        children: [
          CommentFeatureWidget(
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.395,
              width: double.infinity,
              child: Container(
                alignment: Alignment.bottomRight,
                decoration: imageBoxWidget(context, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 32),
                      child: Text(
                        "${profile.name}, ",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      profile.getAge.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    profile.isVerified
                        ? const Icon(Icons.verified_sharp, color: Colors.blue)
                        : const Icon(
                            Icons.verified_outlined,
                            color: Colors.white,
                          ),
                  ],
                ),
              ),
            ),
            profile,
          ),
          Container(
            color: const Color.fromRGBO(15, 15, 15, 1),
            height: MediaQuery.of(context).size.height / 24,
          ),
          CommentFeatureWidget(
            Container(
              color: const Color.fromRGBO(15, 15, 15, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 32,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 32),
                    child: const Text(
                      'Talk to me about',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 32,
                    color: const Color.fromRGBO(15, 15, 15, 1),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.235,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32,
                      right: MediaQuery.of(context).size.width / 32,
                    ),
                    child: const SingleChildScrollView(
                      child: Text(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                        "f1; I'm a real nerd about it. I'm also into software, as you can see by these ginormous specs I'm wearing.",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            profile,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            color: const Color.fromRGBO(15, 15, 15, 1),
          ),
          CommentFeatureWidget(
            Container(
              color: const Color.fromRGBO(15, 15, 15, 1),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: imageBoxWidget(context, 1)),
            ),
            profile,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            color: const Color.fromRGBO(15, 15, 15, 1),
          ),
          CommentFeatureWidget(
            Container(
              color: const Color.fromRGBO(15, 15, 15, 1),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: imageBoxWidget(context, 2)),
            ),
            profile,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            color: const Color.fromRGBO(15, 15, 15, 1),
          ),
          profile.nicheFilterSelected
              ? Container(
                  color: const Color.fromRGBO(15, 15, 15, 1),
                  child: Column(
                    children: [
                      ButtonToSelectUserDatingPreference(
                          "A conversation for now!", profile),
                      SizedBox(height: MediaQuery.of(context).size.height / 64),
                      ButtonToSelectUserDatingPreference(
                          "Looking to be friends.", profile),
                      SizedBox(height: MediaQuery.of(context).size.height / 64),
                      ButtonToSelectUserDatingPreference(
                          "Relationship", profile),
                      SizedBox(height: MediaQuery.of(context).size.height / 64),
                      ButtonToSelectUserDatingPreference("Hookup", profile),
                    ],
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height / 64,
                  color: const Color.fromRGBO(15, 15, 15, 1),
                ),
          Container(
            height: MediaQuery.of(context).size.height / 32,
            color: const Color.fromRGBO(15, 15, 15, 1),
          ),
        ],
      ),
    );
  }

  BoxDecoration imageBoxWidget(BuildContext context, int index) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(profile.firstimageUrl.path),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonToSelectUserDatingPreference extends StatelessWidget {
  String preference;
  Profile profile;
  ButtonToSelectUserDatingPreference(this.preference, this.profile,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(MediaQuery.of(context).size.height / 16),
        backgroundColor: const Color.fromRGBO(231, 10, 95, 0.5),
      ),
      onPressed: () {
        Provider.of<Profile>(context, listen: false)
            .removeLikedProfilesWhenButtonIsClicked(
          profile,
          Container(),
          "",
          preference,
          SwipeType.nicheSelection,
        );
        Provider.of<Profile>(context, listen: false).setLikedListOfProfiles =
            profile;
      },
      child: Text(
        preference,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}
