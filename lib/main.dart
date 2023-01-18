import 'package:dating_made_better/screens/auth_screen.dart';
import 'package:dating_made_better/screens/user_profile_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/profiles.dart';
import './providers/auth.dart';
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
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Profiles(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Dating, made better!',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? const SwipingScreen() : AuthScreen(),
          routes: {
            AuthScreen.routeName: (context) => AuthScreen(),
            SwipingScreen.routeName: (context) => const SwipingScreen(),
            UserProfileScreen.routeName: (context) => const UserProfileScreen(),
            UserProfileCompletionScreen.routeName: (context) =>
                UserProfileCompletionScreen(),
          },
        ),
      ),
    );
  }
}
