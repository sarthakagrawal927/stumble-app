// import 'package:dating_made_better/app_colors.dart';
// import 'package:dating_made_better/providers/profile.dart';
// import 'package:dating_made_better/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../constants.dart';

// class FiltersScreen extends StatefulWidget {
//   const FiltersScreen({super.key});
//   static const routeName = "/filters-screen";

//   @override
//   State<FiltersScreen> createState() => _FiltersScreenState();
// }

// class _FiltersScreenState extends State<FiltersScreen> {
//   @override
//   Widget build(BuildContext context) {
//     List<Gender> selectedGenders =
//         Provider.of<Profile>(context, listen: false).getGenderPreferencesList;
//     RangeValues currentRangeValues =
//         Provider.of<Profile>(context, listen: false).getAgeRangePreference;
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           // temporary solution until proper global state management is implemented
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         actions: const [],
//         title: Text(
//           'Filters',
//           style: AppTextStyles.heading(context),
//         ),
//       ),
//       body: ListView(
//         children: [
//           Container(
//             color: AppColors.secondaryColor,
//             margin: EdgeInsets.only(
//               top: marginWidth16(context),
//               left: marginWidth16(context),
//               right: marginWidth16(context),
//             ),
//             padding: EdgeInsets.all(
//               marginWidth32(context),
//             ),
//             child: Text(
//               textAlign: TextAlign.start,
//               'Do you have a preference for the genders shown to you?',
//               style: AppTextStyles.secondaryHeading(context, size: 18.0),
//             ),
//           ),
//           Card(
//             margin: EdgeInsets.only(
//               top: marginWidth16(context),
//               left: marginWidth16(context),
//               right: marginWidth16(context),
//             ),
//             child: Column(
//               children: [
//                 checkBoxListTileFunction(
//                     'Non-binary people', Gender.nonBinary, selectedGenders),
//                 checkBoxListTileFunction(
//                     'Women', Gender.woman, selectedGenders),
//                 checkBoxListTileFunction('Men', Gender.man, selectedGenders),
//               ],
//             ),
//           ),
//           Container(
//             color: AppColors.secondaryColor,
//             margin: EdgeInsets.only(
//               top: marginWidth16(context),
//               left: marginWidth16(context),
//               right: marginWidth16(context),
//             ),
//             padding: EdgeInsets.all(
//               marginWidth32(context),
//             ),
//             child: Text(
//               textAlign: TextAlign.start,
//               'Do you have a preference for the age of people you want to meet?',
//               style: AppTextStyles.secondaryHeading(context, size: 18.0),
//             ),
//           ),
//           Consumer<Profile>(
//             builder: (context, value, child) => Card(
//               margin: EdgeInsets.only(
//                 top: marginWidth16(context),
//                 left: marginWidth16(context),
//                 right: marginWidth16(context),
//               ),
//               color: widgetColor,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(
//                       marginHeight32(context),
//                     ),
//                     child: Text(
//                       "Between ${currentRangeValues.start.toInt()} and ${currentRangeValues.end.toInt()}",
//                       style: AppTextStyles.chatNameText(context),
//                     ),
//                   ),
//                   SizedBox(height: marginHeight32(context)),
//                   RangeSlider(
//                     activeColor: AppColors.secondaryColor,
//                     inactiveColor: Colors.white30,
//                     values: currentRangeValues,
//                     max: 80,
//                     min: 18,
//                     labels: RangeLabels(
//                       currentRangeValues.start.round().toString(),
//                       currentRangeValues.end.round().toString(),
//                     ),
//                     onChanged: (RangeValues values) {
//                       setState(() {
//                         currentRangeValues = values;
//                         Provider.of<Profile>(context, listen: false)
//                             .setAgeRangePreference = values;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.bottomCenter,
//             margin: EdgeInsets.only(
//                 top: marginWidth16(context), bottom: marginWidth64(context)),
//             padding: EdgeInsets.all(
//               marginWidth32(context),
//             ),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.secondaryColor),
//               onPressed: () async {
//                 Provider.of<Profile>(context, listen: false).upsertUser({
//                   "target_gender": selectedGenders.map((e) => e.index).toList(),
//                   "target_age": [
//                     currentRangeValues.start.toInt(),
//                     currentRangeValues.end.toInt()
//                   ]
//                 }).then((value) => {Navigator.of(context).pop()});
//               },
//               child: Padding(
//                 padding: EdgeInsets.all(
//                   marginWidth32(context),
//                 ),
//                 child: Text("Save preferences!",
//                     style: AppTextStyles.secondaryHeading(context)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   CheckboxListTile checkBoxListTileFunction(
//       final String text, final Gender gender, List<Gender> selectedGenders) {
//     return CheckboxListTile(
//       activeColor: AppColors.secondaryColor,
//       title: Text(text, style: AppTextStyles.dropdownText(context)),
//       value: selectedGenders.contains(gender),
//       onChanged: (_) {
//         setState(() {
//           if (selectedGenders.contains(gender)) {
//             selectedGenders.remove(gender);
//           } else {
//             selectedGenders.add(gender); // select
//           }
//         });
//       },
//       controlAffinity: ListTileControlAffinity.leading,
//     );
//   }
// }
