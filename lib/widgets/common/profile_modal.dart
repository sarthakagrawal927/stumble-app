import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:flutter/material.dart';

class ProfileModal extends StatefulWidget {
  final Profile profile;
  const ProfileModal({super.key, required this.profile});

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.395,
            width: double.infinity,
            child: Container(
              alignment: Alignment.bottomLeft,
              decoration: imageBoxWidget(context, 0),
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 32,
                  right: MediaQuery.of(context).size.width / 32,
                  bottom: MediaQuery.of(context).size.width / 32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    userInformationOnImage(context, widget.profile.getName),
                    userInformationOnImage(
                        context, widget.profile.getAge.toString()),
                    widget.profile.photoVerified
                        ? iconWidget(context, Icons.verified_sharp, Colors.blue)
                        : iconWidget(
                            context, Icons.verified_outlined, Colors.white),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height / 24,
          ),
          Container(
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 16,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32),
                  child: Text(
                    'Talk to me about',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 32,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 32,
                  color: backgroundColor,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.235,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 32,
                    right: MediaQuery.of(context).size.width / 32,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 48,
                        color: Colors.white70,
                      ),
                      widget.profile.conversationStarter,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            color: backgroundColor,
          ),
          if (widget.profile.getPhotos.length > 1) photoWidget(context, 1),
          if (widget.profile.getPhotos.length > 2) photoWidget(context, 2),
        ],
      ),
    );
  }

  Icon iconWidget(BuildContext context, IconData icon, Color color) {
    return Icon(
      icon,
      color: color,
      size: MediaQuery.of(context).size.width / 16,
    );
  }

  Text userInformationOnImage(BuildContext context, String textToDisplay) {
    return Text(
      "$textToDisplay, ",
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.width / 16,
        fontWeight: FontWeight.w900,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget photoWidget(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          color: backgroundColor,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Container(
              alignment: Alignment.bottomLeft,
              decoration: imageBoxWidget(context, 1)),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 16,
          color: backgroundColor,
        ),
      ],
    );
  }

  BoxDecoration imageBoxWidget(BuildContext context, int index) {
    return BoxDecoration(
      color: backgroundColor,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(widget.profile.photos.isNotEmpty
            ? widget.profile.photos[index].path
            : defaultBackupImage),
      ),
    );
  }
}
