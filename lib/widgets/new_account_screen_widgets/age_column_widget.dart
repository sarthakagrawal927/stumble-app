import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  final double _day = 0.0;
  final double _month = 0.0;
  final double _year = 0.0;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DateInputBox(
                controller: dayTextBoxController,
                calendarParameter: _day,
                calendarParameterText: "Day",
              ),
              DateInputBox(
                controller: monthTextBoxController,
                calendarParameter: _month,
                calendarParameterText: "Month",
              ),
              DateInputBox(
                controller: yearTextBoxController,
                calendarParameter: _year,
                calendarParameterText: "Year",
              ),
            ],
          ),
        ),
        // ),
        ScreenGoToNextPageRow(
          "This will be shown on your profile!",
          "",
          () {
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setisAgeSubmittedValue = true;

            Provider.of<Profile>(context, listen: false).setAge =
                (DateTime.now().year) - _year;
          },
        )
      ],
    );
  }
}

class DateInputBox extends StatefulWidget {
  const DateInputBox(
      {super.key,
      required this.controller,
      required this.calendarParameter,
      required this.calendarParameterText});
  final TextEditingController controller;
  final double calendarParameter;
  final String calendarParameterText;

  @override
  // ignore: no_logic_in_create_state
  State<DateInputBox> createState() => _DateInputBoxState(
        controller,
        calendarParameter,
        calendarParameterText,
      );
}

class _DateInputBoxState extends State<DateInputBox> {
  final TextEditingController controller;
  double calendarParameter;
  String calendarParameterText;

  _DateInputBoxState(
      this.controller, this.calendarParameter, this.calendarParameterText);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 8,
      child: TextField(
        controller: controller,
        cursorColor: const Color.fromRGBO(15, 15, 15, 1),
        keyboardAppearance: Brightness.dark,
        style: const TextStyle(
          color: Color.fromRGBO(237, 237, 237, 1),
          decorationColor: Colors.white,
          fontSize: 35,
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 20)),
          labelText: calendarParameterText,
          labelStyle: GoogleFonts.lato(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        keyboardType: TextInputType.datetime,
        onSubmitted: (value) {
          setState(() {
            calendarParameter = double.parse(value);
          });
        },
      ),
    );
  }
}
