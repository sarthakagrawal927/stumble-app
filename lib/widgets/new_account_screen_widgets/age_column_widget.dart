import 'package:age_calculator/age_calculator.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/widgets/common/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile.dart';
import '../newUser/screen_go_to_next_page_row.dart';
import '../newUser/screen_heading_widget.dart';

// ignore: must_be_immutable
class AgeColumn extends StatefulWidget {
  Size deviceSize;
  AgeColumn(this.deviceSize, {super.key});

  @override
  State<AgeColumn> createState() => _AgeColumnState();
}

class _AgeColumnState extends State<AgeColumn> {
  final TextEditingController dateInput = TextEditingController();
  DateTime birthDateInput = DateTime.now();
  DateTime? pickedDate;

  @override
  void dispose() {
    dateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ScreenHeadingWidget("What's your date of birth?"),
        Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.width / 3,
            child: Center(
                child: TextField(
              cursorColor: Colors.white,
              controller: dateInput,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              //editing controller of this TextField
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date", //label text of field
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                iconColor: Colors.white,
                fillColor: Colors.white,
              ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(
                      DateTime.now().year - 70,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                    initialDate: DateTime(
                      DateTime.now().year - 20,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                    lastDate: DateTime(
                      DateTime.now().year - 18,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                    //DateTime.now() - not to al
                    //low to choose before today.
                    initialDatePickerMode: DatePickerMode.day,
                    initialEntryMode: DatePickerEntryMode.calendarOnly);

                if (pickedDate != null) {
                  setState(() {
                    birthDateInput = pickedDate!;
                    dateInput.text = pickedDate.toString().substring(0, 10);
                  });
                }
              },
            ))),
        // ),
        ScreenGoToNextPageRow("This will be shown on your profile!", "", () {
          handleSnackBarIfInputNotFilled(pickedDate != null, () async {
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setNextScreenActive();
            Provider.of<Profile>(context, listen: false).setBirthDate =
                birthDateInput;
            Provider.of<Profile>(context, listen: false).setAge =
                AgeCalculator.age(birthDateInput).years;
          }, context, valueToFill: "date of birth");
        }),
      ],
    );
  }
}
