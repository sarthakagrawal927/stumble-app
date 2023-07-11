import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';
import '../newUser/screen_heading_widget.dart';
import '../newUser/screen_go_to_next_page_row.dart';

// ignore: must_be_immutable
class AgeColumn extends StatefulWidget {
  Size deviceSize;
  AgeColumn(this.deviceSize, {super.key});

  @override
  State<AgeColumn> createState() => _AgeColumnState();
}

class _AgeColumnState extends State<AgeColumn> {
  final dayTextBoxController = TextEditingController();
  final monthTextBoxController = TextEditingController();
  final yearTextBoxController = TextEditingController();

  int _day = 0;
  int _month = 0;
  int _year = 0;

  @override
  void dispose() {
    dayTextBoxController.dispose();
    monthTextBoxController.dispose();
    yearTextBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("What's your date of birth?"),
        Container(
          margin: EdgeInsets.only(
            left: widget.deviceSize.width / 16,
            right: widget.deviceSize.width / 16,
          ),
          padding: EdgeInsets.only(top: widget.deviceSize.height / 32),
          // child: Container(
          //     color: Colors.white,
          //     height: MediaQuery.of(context).size.height / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  controller: dayTextBoxController,
                  cursorColor: backgroundColor,
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Day',
                    labelStyle: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _day = int.parse(value);
                    });
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  controller: monthTextBoxController,
                  cursorColor: backgroundColor,
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Month',
                    labelStyle: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _month = int.parse(value);
                    });
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  controller: yearTextBoxController,
                  cursorColor: backgroundColor,
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Year',
                    labelStyle: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _year = int.parse(value);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        // ),
        ScreenGoToNextPageRow("This will be shown on your profile!", "", () {
          Provider.of<FirstScreenStateProviders>(context, listen: false)
              .setisAgeSubmittedValue = true;
          Provider.of<Profile>(context, listen: false).setAge =
              "$_day-$_month-$_year";
          // Provider.of<Profile>(context, listen: false).createUserAPI();
        }),
      ],
    );
  }
}
