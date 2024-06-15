import 'package:age_calculator/age_calculator.dart';
import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
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
            margin: EdgeInsets.symmetric(
                vertical: marginHeight16(context),
                horizontal: marginWidth24(context)),
            padding: EdgeInsets.all(marginWidth24(context)),
            height: MediaQuery.of(context).size.width / 3,
            child: Center(
                child: TextField(
              cursorColor: AppColors.backgroundColor,
              controller: dateInput,
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: fontSize32(context),
              ),
              //editing controller of this TextField
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date", //label text of field
                labelStyle: TextStyle(
                  color: whiteColor,
                ),
                iconColor: AppColors.backgroundColor,
                fillColor: AppColors.backgroundColor,
              ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                pickedDate = await showDatePicker(
                    barrierColor: AppColors.primaryColor,
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
            ),),),
        ScreenGoToNextPageRow(
          () {
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
