import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const modelOpenedNameToMeta = {
  ModelOpened.userInterestInfoTeaching: {
    "title": "About these options:",
    "description":
        "Our app offers unique features for non-platonic relationships, allowing you to privately select preferences for each individual. Rest assured, your choices remain confidential unless both parties select the same option, reducing fear of judgment during the selection process."
  }
};

// can extend this to show a model for X times, can make the key more dynamic based on thread
Future<void> showModelIfNotShown(
    BuildContext context, ModelOpened modelOpenedName) async {
  await readSecureData(modelOpenedName.toString()).then((hasModelAlreadyShown) {
    if (hasModelAlreadyShown == null || hasModelAlreadyShown.isEmpty) {
      showDialogWidget(context, modelOpenedName);
      writeSecureData(modelOpenedName.toString(), "true");
    }
  });
}

void showDialogWidget(BuildContext context, ModelOpened modelOpenedName) {
  Map<String, String>? meta = modelOpenedNameToMeta[modelOpenedName];
  String title = meta?["title"] ?? "";
  String description = meta?["description"] ?? "";
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: marginHeight64(context), horizontal: marginWidth64(context),),
            child: Dialog(
                backgroundColor: widgetColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: marginHeight64(context),
                            horizontal: marginWidth12(context)),
                        child: Text(
                          title,
                          style: GoogleFonts.sacramento(
                              fontSize: 35,
                              color: headingColor,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: marginHeight64(context),
                            horizontal: marginWidth12(context)),
                        child: Text(
                          description,
                          style: const TextStyle(color: headingColor),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      });
}
