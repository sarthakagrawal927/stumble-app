import 'package:dating_made_better/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});
  static const routeName = "/filters-screen";

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    List<Gender> selectedGenders =
        Provider.of<Profile>(context, listen: false).getGenderPreferencesList;
    RangeValues currentRangeValues =
        Provider.of<Profile>(context, listen: false).getAgeRangePreference;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Color.fromRGBO(231, 10, 95, 1),
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: ListView(
        children: [
          Container(
            color: widgetColor,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 16,
              bottom: MediaQuery.of(context).size.width / 16,
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 32,
            ),
            child: const Text(
              textAlign: TextAlign.start,
              'Do you have a preference for the genders shown to you?',
              style: TextStyle(
                color: Colors.white,
                backgroundColor: backgroundColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 16,
            ),
            color: widgetColor,
            child: Column(
              children: [
                checkBoxListTileFunction(
                    'Nonbinary people', Gender.nonBinary, selectedGenders),
                checkBoxListTileFunction(
                    'Women', Gender.woman, selectedGenders),
                checkBoxListTileFunction('Men', Gender.man, selectedGenders),
              ],
            ),
          ),
          Container(
            color: widgetColor,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 16,
              bottom: MediaQuery.of(context).size.width / 16,
              left: MediaQuery.of(context).size.width / 16,
              right: MediaQuery.of(context).size.width / 32,
            ),
            child: const Text(
              textAlign: TextAlign.start,
              'Do you have a preference for the age of people you want to meet?',
              style: TextStyle(
                color: Colors.white,
                backgroundColor: backgroundColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Consumer<Profile>(
            builder: (context, value, child) => Card(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 16,
                right: MediaQuery.of(context).size.width / 16,
              ),
              color: widgetColor,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 24),
                    child: Text(
                      "Between ${currentRangeValues.start.toInt()} and ${currentRangeValues.end.toInt()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 24),
                  RangeSlider(
                    activeColor: filterScreenTextColor,
                    inactiveColor: Colors.white30,
                    values: currentRangeValues,
                    max: 80,
                    min: 18,
                    divisions: 5,
                    labels: RangeLabels(
                      currentRangeValues.start.round().toString(),
                      currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        currentRangeValues = values;
                        Provider.of<Profile>(context, listen: false)
                            .setAgeRangePreference = values;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 16,
                bottom: MediaQuery.of(context).size.height / 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: filterScreenTextColor),
              onPressed: () async {
                Provider.of<Profile>(context, listen: false).upsertUser({
                  "target_gender": selectedGenders.map((e) => e.index).toList(),
                  "target_age": [
                    currentRangeValues.start.toInt(),
                    currentRangeValues.end.toInt()
                  ]
                }).then((value) => {Navigator.of(context).pop()});
              },
              child: const Text(
                "Save preferences!",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CheckboxListTile checkBoxListTileFunction(
      final String text, final Gender gender, List<Gender> selectedGenders) {
    return CheckboxListTile(
      activeColor: filterScreenHeadingColor,
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 20,
        ),
      ),
      value: selectedGenders.contains(gender),
      onChanged: (_) {
        setState(() {
          if (selectedGenders.contains(gender)) {
            selectedGenders.remove(gender);
          } else {
            selectedGenders.add(gender); // select
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
