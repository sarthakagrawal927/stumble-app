import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../widgets/auth_card.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  VideoPlayerController? _videoPlayerController;
  @override
  void initState() {
    super.initState();
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
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 5.0),
                      child: Text(
                        'Stumble',
                        style: GoogleFonts.sacramento(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 20.0),
                      child: Text(
                        'onto the next part of your life...',
                        style: GoogleFonts.sacramento(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  const AuthCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
