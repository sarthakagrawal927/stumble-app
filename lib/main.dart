import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/firebase_options.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/profile.dart';
import 'screens/login_or_signup_screen.dart';
import './screens/filters_screen.dart';
import './screens/swiping_screen.dart';
import './screens/user_profile_completion_screen.dart';
import './screens/user_profile_overview_screen.dart';

Future<void> _setUserAuthToken() async {
  try {
    await getUserApi();
  } catch (e) {
    debugPrint(e.toString());
  }
}

Widget getScreen() {
  if (getScreenMode() == ScreenMode.swipingScreen) {
    return const SwipingScreen();
  }
  return const AuthScreen();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setUserAuthToken();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  // ChuckerFlutter.showOnRelease = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: FirstScreenStateProviders(getScreenMode())),
        ChangeNotifierProvider.value(
          value: Profile(
            id: 0,
            name: "",
            phoneNumber: "",
            birthDate: DateTime.now(),
            conversationStarter: "",
            gender: Gender.woman,
            photoVerified: false,
            isPlatonic: true,
            genderPreferences: [],
            ageRangePreference: const RangeValues(18, 40),
            photos: [],
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
        home: getScreen(),
        routes: {
          AuthScreen.routeName: (context) => const AuthScreen(),
          SwipingScreen.routeName: (context) => const SwipingScreen(),
          UserProfileScreen.routeName: (context) => const UserProfileScreen(),
          UserProfileCompletionScreen.routeName: (context) =>
              const UserProfileCompletionScreen(),
          // ChatScreen.routeName: (context) => const ChatScreen(),
          MatchesAndChatsScreen.routeName: (context) =>
              const MatchesAndChatsScreen(),
          FiltersScreen.routeName: (context) => const FiltersScreen(),
        },
      ),
    );
  }
}
