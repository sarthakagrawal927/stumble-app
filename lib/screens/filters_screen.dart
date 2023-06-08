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
  List<Gender> selectedGenders = [];
  RangeValues _currentRangeValues = const RangeValues(19, 39);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Color.fromRGBO(231, 10, 95, 1),
          ),
        ),
        backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(15, 15, 15, 0.5),
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
                color: Colors.white70,
                backgroundColor: Color.fromRGBO(15, 15, 15, 1),
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
            color: const Color.fromRGBO(15, 15, 15, 0.5),
            child: Column(
              children: [
                checkBoxListTileFunction('Nonbinary people', Gender.nonBinary),
                checkBoxListTileFunction('Women', Gender.woman),
                checkBoxListTileFunction('Men', Gender.man),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 16,
          ),
          Container(
            color: const Color.fromRGBO(15, 15, 15, 0.5),
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
                color: Colors.white70,
                backgroundColor: Color.fromRGBO(15, 15, 15, 1),
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
            color: const Color.fromRGBO(15, 15, 15, 0.5),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 24),
                  child: Text(
                    "Between ${_currentRangeValues.start.toInt()} and ${_currentRangeValues.end.toInt()}",
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 24),
                RangeSlider(
                  values: _currentRangeValues,
                  max: 40,
                  min: 18,
                  divisions: 5,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<Profile>(context, listen: false)
                  .setAgeRangePreference = _currentRangeValues;
              Provider.of<Profile>(context, listen: false).setGenderPreference =
                  selectedGenders;
            },
            child: const Text(
              "Save preferences!",
              style: TextStyle(fontSize: 20, color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }

  CheckboxListTile checkBoxListTileFunction(
      final String text, final Gender gender) {
    return CheckboxListTile(
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white54,
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
