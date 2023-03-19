import 'package:dating_made_better/screens/user_profile_completion_screen.dart';
import 'package:dating_made_better/widgets/bottom_app_bar.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = "/user-profile-screen";
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 28, 29, 0.5),
      appBar: const TopAppBar(),
      body: Column(
        children: <Widget>[
          Card(
            color: const Color.fromRGBO(26, 28, 29, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: CircleAvatar(
                    maxRadius: 50,
                    minRadius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: const Color.fromRGBO(26, 28, 29, 1),
                  child: const Text(
                    'Profile completion: 20%',
                    style: TextStyle(
                      color: Color.fromRGBO(237, 237, 237, 1),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: const Color.fromRGBO(26, 28, 29, 1),
                      child: const Text(
                        'Rahul Khare, ',
                        style: TextStyle(
                          color: Color.fromRGBO(237, 237, 237, 1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromRGBO(26, 28, 29, 1),
                      child: const Text(
                        '23 ',
                        style: TextStyle(
                          color: Color.fromRGBO(237, 237, 237, 1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromRGBO(26, 28, 29, 1),
                      child: const Icon(
                        color: Colors.blueAccent,
                        Icons.verified_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  child: const Text(
                    'Complete Profile?',
                    style: TextStyle(
                      color: Color.fromRGBO(237, 237, 237, 1),
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, UserProfileCompletionScreen.routeName);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const BottomBar(currentScreen: "UserProfileOverviewScreen"),
    );
  }
}
