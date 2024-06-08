import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/age_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/gender_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/location_disclosure.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/niche_selection_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/otp_screen_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/phone_number_column._widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/photo_addition_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/prompt_addition_column_widget.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/new_account_screen_widgets/first_screen_column_widget.dart';
import '../widgets/new_account_screen_widgets/name_column_widget.dart';

final screenWidgets = {
  ScreenMode.landing: (deviceSize) => FirstScreenColumn(deviceSize),
  ScreenMode.phoneNumberInput: (deviceSize) =>
      PhoneNumberColumnWidget(deviceSize),
  ScreenMode.otpInput: (deviceSize) => OTPScreenColumn(deviceSize),
  ScreenMode.nameInput: (deviceSize) => NameColumn(deviceSize),
  ScreenMode.ageInput: (deviceSize) => AgeColumn(deviceSize),
  ScreenMode.genderInput: (deviceSize) => GenderColumn(deviceSize),
  ScreenMode.photoAdditionInput: (deviceSize) =>
      PhotoAdditionColumn(deviceSize),
  ScreenMode.nicheSelectionInput: (deviceSize) =>
      NicheSelectionColumn(deviceSize),
  ScreenMode.promptAdditionInput: (deviceSize) =>
      PromptAdditionColumn(deviceSize),
  ScreenMode.locationDisclosureScreen: (deviceSize) =>
      LocationDisclosure(deviceSize),
};

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: FloatingBubbles(
              noOfBubbles: 15,
              colorsOfBubbles: const [
                Colors.white38,
                Colors.white70,
              ],
              sizeFactor: 0.16,
              duration: 7,
              opacity: 50,
              paintingStyle: PaintingStyle.fill,
              strokeWidth: 8,
              shape: BubbleShape
                  .circle, // circle is the default. No need to explicitly mention if its a circle.
              speed: BubbleSpeed.normal, // normal is the default
            ),
          ),
          Stack(
            children: <Widget>[
              Consumer<FirstScreenStateProviders>(
                builder: (context, firstScreenStateProviders, _) {
                  return Column(
                    children: [
                      SizedBox(
                        height: deviceSize.height,
                        width: deviceSize.width,
                        child: screenWidgets[firstScreenStateProviders
                                    .getActiveScreenModeValue]
                                ?.call(deviceSize) ??
                            FirstScreenColumn(deviceSize),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
