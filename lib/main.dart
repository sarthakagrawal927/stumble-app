import 'package:dating_made_better/screens/auth_screen.dart';
import 'package:dating_made_better/screens/user_profile_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/profiles.dart';
import './providers/image_input.dart';
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
          create: (context) => ImageInput(),
        ),
        ChangeNotifierProvider(
          create: (context) => Profiles(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Dating, made better!',
          theme: ThemeData(
              textTheme: GoogleFonts.latoTextTheme(
                Theme.of(context).textTheme,
              ),
              // primarySwatch: MaterialColor(#0xF9A25E, color),
              backgroundColor: Color.fromRGBO(105, 50, 30, 1),
              cardColor: Color.fromRGBO(249, 162, 94, 1)),
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
