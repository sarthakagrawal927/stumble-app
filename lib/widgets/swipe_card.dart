import 'package:flutter/material.dart';

import '../providers/profile.dart';

class SwipeCard extends StatelessWidget {
  const SwipeCard({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.395,
            width: double.infinity,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(64),
                  bottomRight: Radius.circular(64),
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.bottomRight,
              decoration: imageBoxWidget(context, 0),
              child: Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 32),
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
                    "${profile.age.toInt()} ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
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
          Container(
            color: const Color.fromRGBO(15, 15, 15, 1),
            height: MediaQuery.of(context).size.height / 15,
          ),
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
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
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
          Container(
            height: MediaQuery.of(context).size.height / 15,
            color: const Color.fromRGBO(15, 15, 15, 1),
          ),
          Container(
            color: const Color.fromRGBO(15, 15, 15, 1),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
                alignment: Alignment.bottomLeft,
                decoration: imageBoxWidget(context, 1)),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            color: const Color.fromRGBO(15, 15, 15, 1),
          ),
          Container(
            color: const Color.fromRGBO(15, 15, 15, 1),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
                alignment: Alignment.bottomLeft,
                decoration: imageBoxWidget(context, 2)),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
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
        image: NetworkImage(profile.imageUrls[0].path),
      ),
    );
  }
}
