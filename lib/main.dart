import 'package:dating_made_better/screens/auth_screen.dart';
import 'package:dating_made_better/screens/chat_screen.dart';
import 'package:dating_made_better/screens/filters_screen.dart';
import 'package:dating_made_better/screens/user_profile_overview_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/profiles.dart';
import './providers/image_input.dart';
import 'screens/newUser/initial_greeting_screen.dart';
import './screens/swiping_screen.dart';
import './screens/user_profile_completion_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ImageInput(),
        ),
        ChangeNotifierProvider(
          create: (context) => Profiles(),
        ),
      ],
      child: MaterialApp(
        title: 'Stumble!',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColorBrightness: Brightness.dark,
          // primarySwatch: MaterialColor(#0xF9A25E, color),
          backgroundColor: Color.fromRGBO(105, 50, 30, 1),
          buttonColor: Color.fromRGBO(1, 177, 177, 0.5),
          accentColor: Color.fromRGBO(249, 162, 94, 0.5),
          splashColor: Color.fromRGBO(60, 42, 33, 1),
          bottomAppBarColor: Color.fromRGBO(27, 18, 11, 1),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SwipingScreen();
            }
            return AuthScreen();
          },
        ),
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          SwipingScreen.routeName: (context) => const SwipingScreen(),
          UserProfileScreen.routeName: (context) => const UserProfileScreen(),
          UserProfileCompletionScreen.routeName: (context) =>
              UserProfileCompletionScreen(),
          ChatScreen.routeName: (context) => ChatScreen(),
          FiltersScreen.routeName: (context) => FiltersScreen(),
          InitialDetailsScreen.routeName: (context) => InitialDetailsScreen(),
        },
      ),
    );
  }
}
