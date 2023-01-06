import 'package:dating_made_better/screens/user_profile_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/profiles.dart';
import './screens/swiping_screen.dart';
import './screens/user_profile_completion_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Profiles(),
        ),
      ],
      child: MaterialApp(
        title: 'Dating, made better!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SwipingScreen(),
        routes: {
          SwipingScreen.routeName: (context) => const SwipingScreen(),
          UserProfileScreen.routeName: (context) => UserProfileScreen(),
          UserProfileCompletionScreen.routeName: (context) =>
              UserProfileCompletionScreen(),
        },
      ),
    );
  }
}
