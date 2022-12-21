import 'package:dating_made_better/screens/user_profile_completion_screen.dart';
import 'package:flutter/material.dart';

import 'screens/user_profile_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dating, made better!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserProfileScreen(),
      routes: {
        UserProfileCompletionScreen.routeName: (context) =>
            UserProfileCompletionScreen(),
      },
    );
  }
}
