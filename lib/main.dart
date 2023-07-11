import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/profile.dart';
import 'screens/login_or_signup_screen.dart';
import 'screens/individual_chats_screen.dart';
import './screens/filters_screen.dart';
import './screens/swiping_screen.dart';
import './screens/user_profile_completion_screen.dart';
import './screens/user_profile_overview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ChuckerFlutter.showOnRelease = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FirstScreenStateProviders()),
        ChangeNotifierProvider.value(
          value: Profile(
            id: "",
            name: "",
            phoneNumber: "",
            birthDate: "",
            conversationStarterPrompt: "",
            gender: Gender.woman,
            isVerified: false,
            firstImageUrl: File(""),
            secondImageUrl: File(""),
            thirdImageUrl: File(""),
            nicheFilterSelected: false,
            genderPreferences: [],
            ageRangePreference: const RangeValues(18, 40),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        title: 'Stumble!',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const AuthScreen(),
        routes: {
          AuthScreen.routeName: (context) => const AuthScreen(),
          SwipingScreen.routeName: (context) => const SwipingScreen(),
          UserProfileScreen.routeName: (context) => const UserProfileScreen(),
          UserProfileCompletionScreen.routeName: (context) =>
              const UserProfileCompletionScreen(),
          ChatScreen.routeName: (context) => const ChatScreen(),
          MatchesAndChatsScreen.routeName: (context) =>
              const MatchesAndChatsScreen(),
          FiltersScreen.routeName: (context) => const FiltersScreen(),
        },
      ),
    );
  }
}
