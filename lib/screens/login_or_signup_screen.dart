import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/age_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/gender_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/otp_screen_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/phone_number_column._widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/photo_addition_column_widget.dart';
import 'package:dating_made_better/widgets/new_account_screen_widgets/prompt_addition_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
  ScreenMode.promptAdditionInput: (deviceSize) =>
      PromptAdditionColumn(deviceSize),
};

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  VideoPlayerController? _videoPlayerController;
  bool isButtonClicked = false;

  @override
  void initState() {
    super.initState();
    isButtonClicked = false;
    _videoPlayerController =
        VideoPlayerController.asset("assets/authScreen_secondVideo.mp4")
          ..initialize().then((_) {
            _videoPlayerController!.play();
            _videoPlayerController!.setLooping(true);
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _videoPlayerController!.value.size.width,
                height: _videoPlayerController!.value.size.height,
                child: VideoPlayer(_videoPlayerController!),
              ),
            ),
          ),
          Consumer<FirstScreenStateProviders>(
              builder: (context, firstScreenStateProviders, _) {
            var activeScreen =
                firstScreenStateProviders.getActiveScreenModeValue;
            return Column(children: [
              SizedBox(
                height: deviceSize.height,
                width: deviceSize.width,
                child: screenWidgets[activeScreen]?.call(deviceSize) ??
                    FirstScreenColumn(deviceSize),
              ),
            ]);
          })
        ],
      ),
    );
  }
}
